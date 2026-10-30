import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static LocalStorage? _instance;
  static SharedPreferences? _preferences;

  LocalStorage._init() {
    _instance = this;
  }

  static LocalStorage get instance {
    if (_instance == null) {
      LocalStorage._init();
    }
    return _instance!;
  }

  Future<SharedPreferences?> initSharedPreferences() async {
    return _preferences = await SharedPreferences.getInstance();
  }

  Future<void> setIsLogin({required bool isLogin}) async {
    await _preferences?.setBool('isLogin', isLogin);
  }

  bool? getIsLogin() {
    return _preferences?.getBool('isLogin');
  }

  Future<void> setNewOrdersAlert({required bool isOn}) async {
    await _preferences?.setBool('newOrdersAlert', isOn);
  }

  bool getNewOrdersAlert() {
    return _preferences?.getBool('newOrdersAlert') ?? true;
  }

  Future<void> setLowStockAlert({required bool isOn}) async {
    await _preferences?.setBool('lowStockAlert', isOn);
  }

  bool getLowStockAlert() {
    return _preferences?.getBool('lowStockAlert') ?? true;
  }

  Future<void> setLanguageCode({required String languageCode}) async {
    await _preferences?.setString('languageCode', languageCode);
  }

  // first launch: follow the device language if it is Arabic
  String getLanguageCode() {
    final saved = _preferences?.getString('languageCode');
    if (saved != null) return saved;
    return PlatformDispatcher.instance.locale.languageCode == 'ar'
        ? 'ar'
        : 'en';
  }

  // light, dark or system
  Future<void> setThemeMode({required String themeMode}) async {
    await _preferences?.setString('themeMode', themeMode);
  }

  String? getThemeMode() {
    return _preferences?.getString('themeMode');
  }
}
