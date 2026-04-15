import 'package:bloc/bloc.dart';
import 'package:waslet_khier/featureAuth/create_acc/data/cubits/registerStatus.dart';
import 'package:waslet_khier/featureAuth/create_acc/data/repo.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final DonorRepo repo;

  RegisterCubit(this.repo) : super(RegisterInitial());

  Future<void> register({
    required String firstName,
    required String lastName,
    required String phone,
    required String email,
    required String password,
  }) async {
    emit(RegisterLoading());

    final result = await repo.registerDonor(
      FirstName: firstName,
      LastName: lastName,
      Phone: phone,
      Email: email,
      Password: password,
    );

    if (result != null && result.isAuthenticated == true) {
      emit(RegisterSuccess());
    } else {
      String errorMessage =
          result?.errors?.email?.first ??
          result?.errors?.password?.first ??
          result?.errors?.phone?.first ??
          result?.message ??
          "حدث خطأ";

      emit(RegisterFailure(errorMessage));
    }
  }
}
