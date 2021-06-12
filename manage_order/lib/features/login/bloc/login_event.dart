part of 'login_bloc.dart';

abstract class LoginEvent {}

class LoginSubmitEvent extends LoginEvent {
  String userName;
  String password;
  LoginSubmitEvent(
    this.userName,
    this.password,
  );
}
