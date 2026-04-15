import 'package:waslet_khier/featureAuth/create_acc/data/Repo/register_repo.dart';

abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {
  final bool isLoading;
  RegisterLoading({required this.isLoading});
}

class RegisterSuccess extends RegisterState {
  final RegisterRepo registerRepo;

  RegisterSuccess({required this.registerRepo});
}

class RegisterFailure extends RegisterState {
  final String message;

  RegisterFailure(this.message);
}
