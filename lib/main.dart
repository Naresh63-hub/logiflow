import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app/app.dart';
import 'core/network/supabase_config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Supabase (with automatic graceful Drift SQLite fallback when unconfigured)
  await SupabaseConfig.initialize();

  runApp(
    const ProviderScope(
      child: LogisticsApp(),
    ),
  );
}
