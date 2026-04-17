abstract class ForgetPasswordState {}

class ForgetPasswordInitial extends ForgetPasswordState {}

class ForgetPasswordLoading extends ForgetPasswordState {}

class ForgetPasswordSuccess extends ForgetPasswordState {
  final String message;
  ForgetPasswordSuccess(this.message);
}

class ForgetPasswordFailure extends ForgetPasswordState {
  final String error;
  ForgetPasswordFailure(this.error);
}

////////////////////////////////////////////////////
class VerifyCodeLoading extends ForgetPasswordState {}

class VerifyCodeSuccess extends ForgetPasswordState {
  final String token;
  VerifyCodeSuccess(this.token);
}

class VerifyCodeFailure extends ForgetPasswordState {
  final String error;
  VerifyCodeFailure(this.error);
}

/////////////////////////////////////////////////////////
class ChangePasswordLoading extends ForgetPasswordState {}

class ChangePasswordSuccess extends ForgetPasswordState {
  final String message;
  ChangePasswordSuccess(this.message);
}

class ChangePasswordFailure extends ForgetPasswordState {
  final String error;
  ChangePasswordFailure(this.error);
}
