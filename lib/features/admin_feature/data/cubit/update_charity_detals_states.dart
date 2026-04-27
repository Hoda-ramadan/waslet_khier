import 'package:equatable/equatable.dart';


sealed class EditCharityState extends Equatable {
  const EditCharityState();
  @override
  List<Object> get props => [];
}

class EditCharityInitial extends EditCharityState {}
class EditCharityLoading extends EditCharityState {}
class EditCharitySuccess extends EditCharityState {}
class EditCharityFailure extends EditCharityState {
  final String message;
  const EditCharityFailure(this.message);
  @override
  List<Object> get props => [message];
}