import 'package:bloc/bloc.dart';
import 'package:waslet_khier/featureAuth/create_acc/data/cubits/registerStatus.dart';
import 'package:waslet_khier/featureAuth/create_acc/data/repo.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final DonorRepo repo;

  RegisterCubit(this.repo) : super(RegisterInitial());

  Future<void> register() async {
    emit(RegisterLoading());

    final result = await repo.registerDonor(
      FirstName: 'Ali',
      LastName: 'Mortada',
      Phone: '01121003827',
      Email: 'elshipanyahmed@gmail.com',
      Password: 'Aa#100200',
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
