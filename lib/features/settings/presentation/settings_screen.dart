import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../core/sync/sync_engine.dart';
import 'settings_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  void _showPrivacyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Privacy & Security Policy'),
        content: const SingleChildScrollView(
          child: Text(
            'LogiFlow Yuva 3PL System complies with enterprise logistics confidentiality standards.\n\n'
            '1. Data Integrity: Consignment tracking and recipient phone numbers are encrypted in transit and at rest.\n'
            '2. Proof of Delivery: Digital signatures and delivery photographs are stored securely and never modified once verified.\n'
            '3. Offline Synchronization: Local changes are stored strictly within the app sandbox SQLite database and transmitted over TLS.\n'
            '4. Permissions: Camera and GPS permissions are requested solely for barcode scanning and delivery geotagging.',
            style: TextStyle(fontSize: 13, height: 1.5),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final syncState = ref.watch(syncEngineProvider);
    final dateFormat = DateFormat('dd MMM yyyy, hh:mm:ss a');

    return Scaffold(
      appBar: AppBar(
        title: Text(context.tr('navSettings')),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Theme Settings Card
          Card(
            margin: EdgeInsets.zero,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.palette_outlined, color: AppColors.secondary),
                      const SizedBox(width: 8),
                      Text(
                        context.tr('theme'),
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  RadioListTile<ThemeMode>(
                    value: ThemeMode.system,
                    groupValue: settings.themeMode,
                    title: Text(context.tr('themeSystem')),
                    onChanged: (val) {
                      if (val != null) ref.read(settingsProvider.notifier).setThemeMode(val);
                    },
                  ),
                  RadioListTile<ThemeMode>(
                    value: ThemeMode.light,
                    groupValue: settings.themeMode,
                    title: Text(context.tr('themeLight')),
                    onChanged: (val) {
                      if (val != null) ref.read(settingsProvider.notifier).setThemeMode(val);
                    },
                  ),
                  RadioListTile<ThemeMode>(
                    value: ThemeMode.dark,
                    groupValue: settings.themeMode,
                    title: Text(context.tr('themeDark')),
                    onChanged: (val) {
                      if (val != null) ref.read(settingsProvider.notifier).setThemeMode(val);
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Language Settings Card
          Card(
            margin: EdgeInsets.zero,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.translate, color: AppColors.accent),
                      const SizedBox(width: 8),
                      Text(
                        context.tr('language'),
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  RadioListTile<String>(
                    value: 'en',
                    groupValue: settings.locale.languageCode,
                    title: const Text('English (English)'),
                    onChanged: (_) {
                      ref.read(settingsProvider.notifier).setLocale(const Locale('en'));
                    },
                  ),
                  RadioListTile<String>(
                    value: 'hi',
                    groupValue: settings.locale.languageCode,
                    title: const Text('हिंदी (Hindi)'),
                    onChanged: (_) {
                      ref.read(settingsProvider.notifier).setLocale(const Locale('hi'));
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Notification Preferences Card
          Card(
            margin: EdgeInsets.zero,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.notifications_active_outlined, color: AppColors.secondary),
                      const SizedBox(width: 8),
                      Text(
                        context.tr('notificationPrefs'),
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(context.tr('pushAlerts')),
                    subtitle: const Text('FCM status milestones & dispatch notices', style: TextStyle(fontSize: 12)),
                    value: settings.pushAlertsEnabled,
                    onChanged: (val) => ref.read(settingsProvider.notifier).setPushAlertsEnabled(val),
                  ),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(context.tr('podAlertsOnly')),
                    subtitle: const Text('Instant confirmation when receiver signs POD', style: TextStyle(fontSize: 12)),
                    value: settings.podAlertsEnabled,
                    onChanged: (val) => ref.read(settingsProvider.notifier).setPodAlertsEnabled(val),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Offline Sync Status Card
          Card(
            margin: EdgeInsets.zero,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.sync, color: AppColors.primaryLight),
                      const SizedBox(width: 8),
                      Text(
                        context.tr('syncStatus'),
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(context.tr('pendingOperations')),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: syncState.pendingCount > 0
                              ? AppColors.warning.withOpacity(0.15)
                              : AppColors.success.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '${syncState.pendingCount} Operations',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: syncState.pendingCount > 0
                                ? AppColors.warning
                                : AppColors.success,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    syncState.lastSyncTime != null
                        ? 'Last Sync: ${dateFormat.format(syncState.lastSyncTime!)}'
                        : 'Last Sync: None in this session',
                    style: const TextStyle(fontSize: 12, color: AppColors.textSecondaryLight),
                  ),
                  const SizedBox(height: 14),
                  ElevatedButton.icon(
                    onPressed: syncState.isSyncing
                        ? null
                        : () async {
                            await ref.read(syncEngineProvider.notifier).syncNow();
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Manual synchronization completed.')),
                              );
                            }
                          },
                    icon: syncState.isSyncing
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                          )
                        : const Icon(Icons.refresh),
                    label: Text(context.tr('manualSync')),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          // About Card
          Card(
            margin: EdgeInsets.zero,
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.info_outline, color: AppColors.secondary),
                  title: Text(context.tr('aboutApp')),
                  subtitle: Text(context.tr('appVersion')),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.school_outlined, color: AppColors.accent),
                  title: const Text('Internship Organization'),
                  subtitle: Text(context.tr('developerCredit')),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.shield_outlined, color: AppColors.primaryLight),
                  title: Text(context.tr('privacyPolicy')),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => _showPrivacyDialog(context),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
