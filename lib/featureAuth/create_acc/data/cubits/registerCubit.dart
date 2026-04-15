import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waslet_khier/featureAuth/create_acc/data/Repo/register_repo.dart';
import 'package:waslet_khier/featureAuth/create_acc/data/cubits/registerStates.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterRepo registerRepo;

  RegisterCubit(this.registerRepo) : super(RegisterInitial());

  Future<void> register() async {
    emit(RegisterLoading(isLoading: true));
    try {
      emit(RegisterSuccess(registerRepo: registerRepo));
    } catch (e) {
      emit(RegisterFailure(e.toString()));
    }
  }
}
