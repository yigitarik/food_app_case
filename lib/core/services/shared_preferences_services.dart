import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  late SharedPreferences _preferences;

  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  setStringValue({required String key, required dynamic value}) {
    _preferences.setString(key, value);
  }

  getStringValue({required String key}) {
    return _preferences.getString(key);
  }

  bool containsKeyCheck({required String key}) {
    return _preferences.containsKey(key);
  }
}
