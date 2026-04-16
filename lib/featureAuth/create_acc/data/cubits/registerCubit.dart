import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waslet_khier/featureAuth/create_acc/data/Repo/register_repo.dart';
import 'package:waslet_khier/featureAuth/create_acc/data/cubits/registerStates.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterRepo registerRepo;

  RegisterCubit(this.registerRepo) : super(RegisterInitial());

  Future<void> register({
    required String FirstName,
    required String LastName,
    required String Phone,
    required String Email,
    required String Password,
    String? imagePath,
  }) async {
    emit(RegisterLoading(isLoading: true));
    try {
      final result = await registerRepo.registerDonor(
        firstName: FirstName,
        lastName: LastName,
        phone: Phone,
        email: Email,
        password: Password,
        imagePath: imagePath,
      );

      if (result.isAuthenticated == true) {
        emit(RegisterSuccess(donorRegister: result));
      } else {
        emit(RegisterFailure(result.message ?? 'حدث خطأ، حاول مرة أخرى'));
      }
    } catch (e) {
      emit(RegisterFailure(e.toString().replaceAll('Exception: ', '')));
    }
  }
}
