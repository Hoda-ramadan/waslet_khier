import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waslet_khier/features/Donation_feature/data/cubit/donation_state%20(1).dart';
import 'package:waslet_khier/features/Donation_feature/data/repo/donation_repo%20(1).dart';

class DonationCubit extends Cubit<DonationState> {
  final DonationRepo repo;

  DonationCubit(this.repo) : super(DonationInitial());

  Future<void> donate({
    required int donorId,
    required int caseId,
    required double amount,
  }) async {
    emit(DonationLoading());
    try {
      await repo.addDonation(donorId: donorId, caseId: caseId, amount: amount);
      emit(DonationSuccess());
    } catch (e) {
      emit(DonationFailed(errorMessage: e.toString()));
    }
  }
}
