import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  static final AppPreferences _instance = AppPreferences._internal();

  factory AppPreferences() {
    return _instance;
  }

  AppPreferences._internal();

  late SharedPreferences _prefs;

  Future<void> initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  //late bool firstTime;

  String get userName {
    return _prefs.getString('userName') ?? "";
  }

  set userName(String value) {
    _prefs.setString('userName', value);
  }

  bool get isFirstTime {
    return _prefs.getBool('firstTime') ?? true;
  }

  set isFirstTime(bool value) {
    _prefs.setBool('firstTime', value);
  }

  bool get isBiometricEnable {
    return _prefs.getBool('initWithBiometric') ?? false;
  }

  set isBiometricEnable(bool value) {
    _prefs.setBool('initWithBiometric', value);
  }
}
