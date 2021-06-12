import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:manage_order/features/info_order/bloc/info_order_bloc.dart';
import 'package:manage_order/features/info_order/interactor/info_order_interactor.dart';
import 'package:manage_order/features/info_order/repository/info_order_repository.dart';
import 'package:manage_order/services/prefs/app_preferences.dart';
import 'package:manage_order/services/prefs/app_preferences_imple.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../configurations/configurations.dart';
import '../../features/login/bloc/login_bloc.dart';
import '../../features/login/interactor/login_interactor.dart';
import '../../features/login/repository/login_repository.dart';
import '../../services/API_request/api_client.dart';
import '../../services/network/dio_client.dart';
import '../../services/network/logger_interceptor.dart';

GetIt injector = GetIt.instance;

class DependencyInjection {
  static Future<void> inject() async {
    // register local storage
    final sharedPreferences = await SharedPreferences.getInstance();
    injector.registerFactory<AppPreferences>(
      () => AppPreferencesImpl(sharedPreferences: sharedPreferences),
    );

    final _dio = await DioClient.setup(
      baseUrl: Configurations.baseUrl,
    );
    if (kDebugMode) {
      _dio.interceptors.add(LoggerInterceptor());
    }
    final _appApiClient = ApiClient(
      _dio,
      baseUrl: Configurations.baseUrl,
    );

    // register bloc
    injector.registerFactory<LoginBloc>(
      () => LoginBloc(
        interactor: LoginInteractor(
          repository: LoginRepository(
            apiClient: _appApiClient,
          ),
        ),
      ),
    );
    injector.registerFactory<InfoOrderBloc>(
      () => InfoOrderBloc(
        interactor: InfoOrderInteractor(
          repository: InfoOrderRepository(
            apiClient: _appApiClient,
          ),
        ),
      ),
    );
  }
}
