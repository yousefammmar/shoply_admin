import 'package:flutter/material.dart';

class AppSettingsState {
  final Locale locale;
  final ThemeMode themeMode;

  const AppSettingsState({required this.locale, required this.themeMode});

  AppSettingsState copyWith({Locale? locale, ThemeMode? themeMode}) {
    return AppSettingsState(
      locale: locale ?? this.locale,
      themeMode: themeMode ?? this.themeMode,
    );
  }
}
