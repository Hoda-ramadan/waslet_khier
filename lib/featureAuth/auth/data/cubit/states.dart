import 'package:waslet_khier/featureAuth/auth/data/models/login_model.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final LoginModel model;

  LoginSuccess(this.model);
}

class LoginFailure extends LoginState {
  final String message;

  LoginFailure(this.message);
}
