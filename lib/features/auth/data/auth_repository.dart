import 'package:drift/drift.dart';
import '../../../core/database/app_database.dart';
import '../../../core/network/supabase_config.dart';
import '../domain/user_model.dart';

class AuthRepository {
  final AppDatabase _db;

  AuthRepository(this._db);

  // Pre-configured Demo Users for evaluation & offline demonstrations
  static const UserModel demoShipper = UserModel(
    id: 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa',
    email: 'shipper@yuvaintern.com',
    fullName: 'Amit Sharma',
    phone: '+91 98712 34567',
    role: UserRole.shipper,
    avatarUrl: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=150',
  );

  static const UserModel demoHubManager = UserModel(
    id: 'bbbbbbbb-bbbb-bbbb-bbbb-bbbbbbbbbbbb',
    email: 'manager@yuvaintern.com',
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
    // 1. Check for quick demo credentials
    if (email.trim().toLowerCase() == demoShipper.email) {
      await _cacheUser(demoShipper);
      return demoShipper;
    }
    if (email.trim().toLowerCase() == demoHubManager.email) {
      await _cacheUser(demoHubManager);
      return demoHubManager;
    }

    // 2. If live Supabase is configured, authenticate with Supabase Auth
    final supabase = SupabaseConfig.client;
    if (supabase != null && SupabaseConfig.isRealBackendConfigured) {
      final res = await supabase.auth.signInWithPassword(
        email: email.trim(),
        password: password,
      );
      if (res.user != null) {
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
      }
    }

    // 3. Fallback demo user for arbitrary valid login
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
