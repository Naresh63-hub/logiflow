import 'package:drift/drift.dart';
import '../../../core/database/app_database.dart';
import '../../../core/network/supabase_config.dart';
import '../domain/user_model.dart';

class AuthRepository {
  final AppDatabase _db;

  AuthRepository(this._db);

  // Pre-configured Demo Users for offline evaluation without live Supabase credentials
  static const UserModel demoShipper = UserModel(
    id: 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa',
    email: 'shipper@logiflow.in',
    fullName: 'Amit Sharma',
    phone: '+91 98712 34567',
    role: UserRole.shipper,
    avatarUrl: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=150',
  );

  static const UserModel demoHubManager = UserModel(
    id: 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
    email: 'manager@logiflow.in',
    fullName: 'Rajesh Kumar',
    phone: '+91 98101 23456',
    role: UserRole.hubManager,
    hubId: '11111111-1111-1111-1111-111111111111',
    avatarUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150',
  );

  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    final supabase = SupabaseConfig.client;

    // 1. Live Supabase Authentication when backend is configured
    if (supabase != null && SupabaseConfig.isRealBackendConfigured) {
      final res = await supabase.auth.signInWithPassword(
        email: email.trim(),
        password: password,
      );
      if (res.user == null) {
        throw Exception('Invalid Supabase credentials');
      }

      final profileData = await supabase
          .from('profiles')
          .select()
          .eq('id', res.user!.id)
          .maybeSingle();

      if (profileData != null) {
        final user = UserModel.fromJson(profileData);
        await _cacheUser(user);
        return user;
      }

      // Create profile fallback if trigger wasn't executed yet
      final meta = res.user!.userMetadata ?? {};
      final newRole = UserRole.fromString(meta['role'] as String? ?? 'shipper');
      final fallback = UserModel(
        id: res.user!.id,
        email: res.user!.email ?? email.trim(),
        fullName: meta['full_name'] as String? ?? email.split('@').first,
        phone: meta['phone'] as String? ?? '+91 98000 00000',
        role: newRole,
        hubId: newRole == UserRole.hubManager ? '11111111-1111-1111-1111-111111111111' : null,
      );
      await supabase.from('profiles').upsert(fallback.toJson());
      await _cacheUser(fallback);
      return fallback;
    }

    // 2. Offline Demo Fallback Mode (no Supabase project configured)
    if (email.trim().toLowerCase() == demoShipper.email) {
      await _cacheUser(demoShipper);
      return demoShipper;
    }
    if (email.trim().toLowerCase() == demoHubManager.email) {
      await _cacheUser(demoHubManager);
      return demoHubManager;
    }

    final fallbackUser = UserModel(
      id: 'demo-user-${email.hashCode}',
      email: email.trim(),
      fullName: email.split('@').first.replaceAll('.', ' ').toUpperCase(),
      phone: '+91 98000 00000',
      role: email.contains('manager') ? UserRole.hubManager : UserRole.shipper,
      hubId: email.contains('manager') ? '11111111-1111-1111-1111-111111111111' : null,
    );
    await _cacheUser(fallbackUser);
    return fallbackUser;
  }

  Future<UserModel?> signUp({
    required String email,
    required String password,
    required String fullName,
    required String phone,
    required UserRole role,
  }) async {
    final supabase = SupabaseConfig.client;
    if (supabase != null && SupabaseConfig.isRealBackendConfigured) {
      final res = await supabase.auth.signUp(
        email: email.trim(),
        password: password,
        data: {
          'full_name': fullName.trim(),
          'phone': phone.trim(),
          'role': role.toDbString(),
        },
      );
      if (res.user == null) {
        throw Exception('Account creation failed');
      }

      // If email confirmation is disabled in Supabase, session is active immediately
      if (res.session != null) {
        final user = UserModel(
          id: res.user!.id,
          email: email.trim(),
          fullName: fullName.trim(),
          phone: phone.trim(),
          role: role,
          hubId: role == UserRole.hubManager ? '11111111-1111-1111-1111-111111111111' : null,
        );
        await supabase.from('profiles').upsert(user.toJson());
        await _cacheUser(user);
        return user;
      }
      // Return null to signify email confirmation check is required before login
      return null;
    }

    // Offline Demo Sign Up
    final offlineUser = UserModel(
      id: 'demo-user-${email.hashCode}',
      email: email.trim(),
      fullName: fullName.trim(),
      phone: phone.trim(),
      role: role,
      hubId: role == UserRole.hubManager ? '11111111-1111-1111-1111-111111111111' : null,
    );
    await _cacheUser(offlineUser);
    return offlineUser;
  }

  Future<void> resetPassword(String email) async {
    final supabase = SupabaseConfig.client;
    if (supabase != null && SupabaseConfig.isRealBackendConfigured) {
      await supabase.auth.resetPasswordForEmail(email.trim());
    }
  }

  Future<void> _cacheUser(UserModel user) async {
    await _db.into(_db.profiles).insertOnConflictUpdate(
          ProfilesCompanion.insert(
            id: user.id,
            fullName: user.fullName,
            email: user.email,
            phone: user.phone,
            role: user.role.toDbString(),
            hubId: Value(user.hubId),
            avatarUrl: Value(user.avatarUrl),
          ),
        );
  }

  Future<UserModel?> getCachedUser() async {
    final cached = await _db.select(_db.profiles).get();
    if (cached.isNotEmpty) {
      final p = cached.first;
      return UserModel(
        id: p.id,
        email: p.email,
        fullName: p.fullName,
        phone: p.phone,
        role: UserRole.fromString(p.role),
        hubId: p.hubId,
        avatarUrl: p.avatarUrl,
      );
    }
    return null;
  }

  Future<UserModel> updateProfile(UserModel updated) async {
    await _cacheUser(updated);
    final supabase = SupabaseConfig.client;
    if (supabase != null && SupabaseConfig.isRealBackendConfigured) {
      try {
        await supabase.from('profiles').update({
          'full_name': updated.fullName,
          'phone': updated.phone,
        }).eq('id', updated.id);
      } catch (_) {}
    }
    return updated;
  }

  Future<void> logout() async {
    final supabase = SupabaseConfig.client;
    if (supabase != null) {
      try {
        await supabase.auth.signOut();
      } catch (_) {}
    }
    await _db.delete(_db.profiles).go();
  }
}
