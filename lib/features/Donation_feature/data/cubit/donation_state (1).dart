import 'package:equatable/equatable.dart';

abstract class DonationState extends Equatable {
  const DonationState();

  @override
  List<Object?> get props => [];
}

class DonationInitial extends DonationState {}

class DonationLoading extends DonationState {}

class DonationSuccess extends DonationState {}

class DonationFailed extends DonationState {
  final String errorMessage;
  const DonationFailed({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
