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
    emit(RegisterLoading(isLoading: true));

    final result = await repo.registerDonor(
      firstName: firstName,
      lastName: lastName,
      phone: phone,
      email: email,
      password: password,
    );

    if (result != null && (result.status == 200 || result.status == 201)) {
      emit(RegisterSuccess());
    } else {
      String errorMessage =
          result?.errors?.email?.first ??
          result?.errors?.password?.first ??
          result?.errors?.phone?.first ??
          "حدث خطأ";

      emit(RegisterFailure(errorMessage));
    }
  }
}
