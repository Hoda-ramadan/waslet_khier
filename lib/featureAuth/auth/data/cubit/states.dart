

import 'package:equatable/equatable.dart';
import 'package:waslet_khier/featureAuth/auth/data/models/login_response_model.dart';


abstract class LoginState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final LoginResponse loginResponse;
  LoginSuccess(this.loginResponse);

  @override
  List<Object?> get props => [loginResponse];
}

class LoginFailure extends LoginState {
  final String message;
  LoginFailure(this.message);

  @override
  List<Object?> get props => [message];
}