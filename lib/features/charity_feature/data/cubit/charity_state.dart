part of 'charity_deteals_cubit.dart';

sealed class CharityState extends Equatable {
  const CharityState();

  @override
  List<Object> get props => [];
}

final class CharityInitial extends CharityState {}

final class CharityLodaing extends CharityState {}

final class CharitySuccess extends CharityState {
  const CharitySuccess({required this.charites});
  final List<CharityModel> charites;
}

final class CharityFaild extends CharityState {
  final String errorMessage;

  const CharityFaild({required this.errorMessage});
}

class CharityDetailsLoading extends CharityState {}

class CharityDetailsSuccess extends CharityState {
  final CharityModel charity;

  CharityDetailsSuccess(this.charity);
}

class CharityDetailsFaild extends CharityState {
  final String error;

  CharityDetailsFaild(this.error);
}
