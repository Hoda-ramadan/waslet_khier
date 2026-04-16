// featureAuth/create_acc/data/cubits/registerStates.dart

import 'package:equatable/equatable.dart';
import 'package:waslet_khier/featureAuth/create_acc/data/Model/donor_register.dart';

abstract class RegisterState extends Equatable {
  @override
  List<Object?> get props => [];
}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {
  final bool isLoading;
  RegisterLoading({required this.isLoading});

  @override
  List<Object?> get props => [isLoading];
}

class RegisterSuccess extends RegisterState {
  final DonorRegister donorRegister;
  RegisterSuccess({required this.donorRegister});

  @override
  List<Object?> get props => [donorRegister];
}

class RegisterFailure extends RegisterState {
  final String message;
  RegisterFailure(this.message);

  @override
  List<Object?> get props => [message];
}
