import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsState {
  final ThemeMode themeMode;
  final Locale locale;
  final bool pushAlertsEnabled;
  final bool podAlertsEnabled;

  const SettingsState({
    this.themeMode = ThemeMode.system,
    this.locale = const Locale('en'),
    this.pushAlertsEnabled = true,
    this.podAlertsEnabled = true,
  });

  SettingsState copyWith({
    ThemeMode? themeMode,
    Locale? locale,
    bool? pushAlertsEnabled,
    bool? podAlertsEnabled,
  }) {
    return SettingsState(
      themeMode: themeMode ?? this.themeMode,
      locale: locale ?? this.locale,
      pushAlertsEnabled: pushAlertsEnabled ?? this.pushAlertsEnabled,
      podAlertsEnabled: podAlertsEnabled ?? this.podAlertsEnabled,
    );
  }
}

class SettingsNotifier extends StateNotifier<SettingsState> {
  SettingsNotifier() : super(const SettingsState()) {
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final themeStr = prefs.getString('app_theme');
      final langCode = prefs.getString('app_language');
      final pushAlerts = prefs.getBool('push_alerts_enabled') ?? true;
      final podAlerts = prefs.getBool('pod_alerts_enabled') ?? true;

      ThemeMode mode = ThemeMode.system;
      if (themeStr == 'light') mode = ThemeMode.light;
      if (themeStr == 'dark') mode = ThemeMode.dark;

      Locale loc = const Locale('en');
      if (langCode == 'hi') loc = const Locale('hi');

      state = state.copyWith(
        themeMode: mode,
        locale: loc,
        pushAlertsEnabled: pushAlerts,
        podAlertsEnabled: podAlerts,
      );
    } catch (_) {}
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    state = state.copyWith(themeMode: mode);
    try {
      final prefs = await SharedPreferences.getInstance();
      String val = 'system';
      if (mode == ThemeMode.light) val = 'light';
      if (mode == ThemeMode.dark) val = 'dark';
      await prefs.setString('app_theme', val);
    } catch (_) {}
  }

  Future<void> setLocale(Locale loc) async {
    state = state.copyWith(locale: loc);
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('app_language', loc.languageCode);
    } catch (_) {}
  }

  Future<void> setPushAlertsEnabled(bool enabled) async {
    state = state.copyWith(pushAlertsEnabled: enabled);
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('push_alerts_enabled', enabled);
    } catch (_) {}
  }

  Future<void> setPodAlertsEnabled(bool enabled) async {
    state = state.copyWith(podAlertsEnabled: enabled);
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('pod_alerts_enabled', enabled);
    } catch (_) {}
  }
}

final settingsProvider = StateNotifierProvider<SettingsNotifier, SettingsState>((ref) {
  return SettingsNotifier();
});
