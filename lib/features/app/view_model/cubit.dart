import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoply_admin/core/local/local_storage.dart';
import 'package:shoply_admin/features/app/view_model/state.dart';

// App language and theme, restored from local storage at startup
class AppSettingsCubit extends Cubit<AppSettingsState> {
  AppSettingsCubit()
    : super(
        AppSettingsState(
          locale: Locale(LocalStorage.instance.getLanguageCode()),
          themeMode:
              ThemeMode.values.asNameMap()[LocalStorage.instance
                  .getThemeMode()] ??
              ThemeMode.system,
        ),
      );

  Future<void> changeLanguage(String languageCode) async {
    if (languageCode == state.locale.languageCode) return;
    emit(state.copyWith(locale: Locale(languageCode)));
    await LocalStorage.instance.setLanguageCode(languageCode: languageCode);
  }

  Future<void> changeThemeMode(ThemeMode themeMode) async {
    if (themeMode == state.themeMode) return;
    emit(state.copyWith(themeMode: themeMode));
    await LocalStorage.instance.setThemeMode(themeMode: themeMode.name);
  }
}
