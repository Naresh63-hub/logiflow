import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseConfig {
  static const String defaultUrl = 'https://xyzcompanylogistics.supabase.co';
  static const String defaultAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.e30.dummyKeyForYuvaInternOfflineDemo';

  static String url = defaultUrl;
  static String anonKey = defaultAnonKey;

  static bool _isInitialized = false;
  static bool get isInitialized => _isInitialized;

  static bool get isRealBackendConfigured =>
      url != defaultUrl &&
      anonKey != defaultAnonKey &&
      url.contains('supabase.co');

  static Future<void> initialize({String? customUrl, String? customKey}) async {
    url = customUrl ?? defaultUrl;
    anonKey = customKey ?? defaultAnonKey;

    try {
      if (isRealBackendConfigured) {
        await Supabase.initialize(
          url: url,
          // ignore: deprecated_member_use
          anonKey: anonKey,
        );
        _isInitialized = true;
        debugPrint('[SupabaseConfig] Connected to live Supabase project.');
      } else {
        // In local/test mode without live keys, mark uninitialized so repositories seamlessly use Drift offline DB
        _isInitialized = false;
        debugPrint('[SupabaseConfig] Running in offline-first mode with Drift SQLite engine.');
      }
    } catch (e) {
      _isInitialized = false;
      debugPrint('[SupabaseConfig] Initialization caught: $e. Operating in local Drift mode.');
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
