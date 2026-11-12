import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseConfig {
  static const String _envUrl = String.fromEnvironment('SUPABASE_URL');
  static const String _envAnonKey = String.fromEnvironment('SUPABASE_ANON_KEY');

  static const String defaultUrl = 'https://xyzcompanylogistics.supabase.co';
  static const String defaultAnonKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.e30.placeholderOfflineDemoKey';
  static const String podStorageBucket = 'pod-evidence';

  static String url = _envUrl.isNotEmpty ? _envUrl : defaultUrl;
  static String anonKey = _envAnonKey.isNotEmpty ? _envAnonKey : defaultAnonKey;

  static bool _isInitialized = false;
  static bool get isInitialized => _isInitialized;

  static bool get isRealBackendConfigured =>
      url != defaultUrl &&
      anonKey != defaultAnonKey &&
      url.startsWith('https://') &&
      url.contains('.supabase.co') &&
      anonKey.length > 20;

  static Future<void> initialize({String? customUrl, String? customKey}) async {
    String? savedUrl;
    String? savedKey;

    try {
      final prefs = await SharedPreferences.getInstance();
      savedUrl = prefs.getString('custom_supabase_url');
      savedKey = prefs.getString('custom_supabase_anon_key');
    } catch (_) {}

    if (customUrl != null && customUrl.isNotEmpty) {
      url = customUrl.trim();
    } else if (_envUrl.isNotEmpty) {
      url = _envUrl.trim();
    } else if (savedUrl != null && savedUrl.isNotEmpty) {
      url = savedUrl.trim();
    } else {
      url = defaultUrl;
    }

    if (customKey != null && customKey.isNotEmpty) {
      anonKey = customKey.trim();
    } else if (_envAnonKey.isNotEmpty) {
      anonKey = _envAnonKey.trim();
    } else if (savedKey != null && savedKey.isNotEmpty) {
      anonKey = savedKey.trim();
    } else {
      anonKey = defaultAnonKey;
    }

    await _connectIfValid();
  }

  static Future<bool> saveAndConnect({
    required String newUrl,
    required String newAnonKey,
  }) async {
    final cleanUrl = newUrl.trim();
    final cleanKey = newAnonKey.trim();

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('custom_supabase_url', cleanUrl);
    await prefs.setString('custom_supabase_anon_key', cleanKey);

    url = cleanUrl;
    anonKey = cleanKey;
    return await _connectIfValid();
  }

  static Future<void> resetToOfflineDemo() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('custom_supabase_url');
    await prefs.remove('custom_supabase_anon_key');
    url = defaultUrl;
    anonKey = defaultAnonKey;
    _isInitialized = false;
  }

  static Future<bool> _connectIfValid() async {
    try {
      if (isRealBackendConfigured) {
        await Supabase.initialize(
          url: url,
          // ignore: deprecated_member_use
          anonKey: anonKey,
        );
        _isInitialized = true;
        debugPrint('[SupabaseConfig] Connected to live Supabase project: $url');
        return true;
      } else {
        _isInitialized = false;
        debugPrint('[SupabaseConfig] Running in offline-first mode with Drift SQLite engine.');
        return false;
      }
    } catch (e) {
      // Note: Supabase.initialize throws if already initialized in same app session
      if (e.toString().contains('already been initialized')) {
        _isInitialized = true;
        return true;
      }
      _isInitialized = false;
      debugPrint('[SupabaseConfig] Initialization caught: $e. Operating in local Drift mode.');
      return false;
    }
  }

  static SupabaseClient? get client {
    if (_isInitialized) {
      try {
        return Supabase.instance.client;
      } catch (_) {
        return null;
      }
    }
    return null;
  }
}
