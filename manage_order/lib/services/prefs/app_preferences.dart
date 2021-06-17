abstract class AppPreferences {
  Future<bool> saveIdUser(String data);
  String? getIdUser();

  Future<bool> saveRoleUser(String data);
  String? getRoleUser();
  Future<void> clear();

  static const String idUser = 'id_user';
  static const String roleUser = 'role_user';
}

class TypeUser {
  static const baohang = 'baohang';
  static const thukho = 'thukho';
}
