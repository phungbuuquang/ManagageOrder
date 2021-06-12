import 'package:manage_order/data/models/remote/login_response.dart';
import 'package:manage_order/services/API_request/api_client.dart';

class LoginRepository {
  final ApiClient apiClient;

  LoginRepository({required this.apiClient});

  Future<LoginResponse?> login(
    String userName,
    String password,
  ) async {
    final response = await apiClient.login(
      userName,
      password,
    );
    return response;
  }
}
