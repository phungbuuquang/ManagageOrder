import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../configurations/configurations.dart';
import '../../features/info_order/bloc/info_order_bloc.dart';
import '../../features/info_order/interactor/info_order_interactor.dart';
import '../../features/info_order/repository/info_order_repository.dart';
import '../../features/login/bloc/login_bloc.dart';
import '../../features/login/interactor/login_interactor.dart';
import '../../features/login/repository/login_repository.dart';
import '../../features/print_bill/bloc/printer_bloc.dart';
import '../../features/print_bill/interactor/printer_interactor.dart';
import '../../features/print_bill/repository/printer_repository.dart';
import '../../features/stocker/bloc/stocker_bloc.dart';
import '../../features/stocker/interactor/stocker_interactor.dart';
import '../../features/stocker/repository/stocker_repository.dart';
import '../../services/API_request/api_client.dart';
import '../../services/network/dio_client.dart';
import '../../services/network/logger_interceptor.dart';
import '../../services/prefs/app_preferences.dart';
import '../../services/prefs/app_preferences_imple.dart';

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
    injector.registerFactory<PrinterBloc>(
      () => PrinterBloc(
        interactor: PrinterInteractor(
          repository: PrinterRepository(
            apiClient: _appApiClient,
          ),
        ),
      ),
    );
    injector.registerFactory<StockerBloc>(
      () => StockerBloc(
        interactor: StockerInteractor(
          repository: StockerRepository(
            apiClient: _appApiClient,
          ),
        ),
      ),
    );
  }
}
