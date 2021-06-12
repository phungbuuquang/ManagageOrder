import 'package:shared_preferences/shared_preferences.dart';

import 'app_preferences.dart';

class AppPreferencesImpl extends AppPreferences {
  final SharedPreferences sharedPreferences;
  AppPreferencesImpl({
    required this.sharedPreferences,
  });
  @override
  String? getIdUser() {
    return sharedPreferences.getString(AppPreferences.idUser);
  }

  @override
  String? getRoleUser() {
    return sharedPreferences.getString(AppPreferences.roleUser);
  }

  @override
  Future<bool> saveIdUser(String data) {
    return sharedPreferences.setString(AppPreferences.idUser, data);
  }

  @override
  Future<bool> saveRoleUser(String data) {
    return sharedPreferences.setString(AppPreferences.roleUser, data);
  }

  @override
  Future<void> clear() async {
    await sharedPreferences.clear();
  }
}
