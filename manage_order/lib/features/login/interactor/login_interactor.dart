import 'package:manage_order/components/depency_injection/di.dart';
import 'package:manage_order/services/prefs/app_preferences.dart';

import '../../../data/models/remote/login_response.dart';
import '../repository/login_repository.dart';

class LoginInteractor {
  final LoginRepository repository;
  LoginInteractor({
    required this.repository,
  });

  saveLogin(LoginResponse data) {
    injector.get<AppPreferences>().saveIdUser(
          data.idNguoiDung.toString(),
        );
    injector.get<AppPreferences>().saveRoleUser(data.quyen ?? '');
  }

  Future<LoginResponse?> login(
    String userName,
    String password,
  ) {
    return repository.login(
      userName,
      password,
    );
  }
}
