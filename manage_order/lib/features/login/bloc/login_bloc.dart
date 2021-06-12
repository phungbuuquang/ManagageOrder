import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manage_order/features/login/interactor/login_interactor.dart';
import 'package:uuid/uuid.dart';

import '../../../data/models/remote/login_response.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required this.interactor,
  }) : super(
          LoginInitialState(),
        );
  final LoginInteractor interactor;
  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginSubmitEvent) {
      yield* _mapLoginSubmitEventToState(
        event,
        state,
      );
    }
  }

  Stream<LoginState> _mapLoginSubmitEventToState(
    LoginSubmitEvent event,
    LoginState state,
  ) async* {
    yield LoginLoadingState();
    final response = await interactor.login(
      event.userName,
      event.password,
    );
    if (response != null) {
      if (response.idNguoiDung != -1) {
        interactor.saveLogin(response);
        yield LoginSuccessState(response);
      } else {
        yield LoginFailedState();
      }
      return;
    }
    yield LoginFailedState();
  }
}
