import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waslet_khier/features/profile_feature/data/favCubit/favstate.dart';
import 'package:waslet_khier/features/profile_feature/data/favrepo/FavoriteRepo.dart';
import 'package:waslet_khier/features/profile_feature/data/models/favorite_model/favorite_model.dart';

class Favcubit extends Cubit<FavorieState> {
  final Favoriterepo repo;

  Favcubit(this.repo) : super(FavoritInitial());

  // ✅ FIXED: بيبعت donorId دلوقتي
  Future<void> getfav(int donorId) async {
    emit(favoritLodaing());
    try {
      final result = await repo.getFavoritcase(donorId);
      emit(FavoritSuccess(favorit: result));
    } catch (e) {
      emit(FavoritFaild(errorMessage: e.toString()));
    }
  }

  // ✅ NEW: toggle القلب
  Future<void> toggleFavorite({
    required int donorId,
    required int caseId,
  }) async {
    final currentState = state;
    if (currentState is! FavoritSuccess) return;

    final alreadyFav = currentState.favorit.any((e) => e.caseId == caseId);

    // optimistic update - غير الـ UI فوراً
    List<FavoriteModel> optimisticList;
    if (alreadyFav) {
      optimisticList = currentState.favorit
          .where((e) => e.caseId != caseId)
          .toList();
    } else {
      optimisticList = [
        ...currentState.favorit,
        FavoriteModel(caseId: caseId, donorId: donorId),
      ];
    }
    emit(FavoritSuccess(favorit: optimisticList));

    try {
      if (alreadyFav) {
        await repo.removeFavoriteCase(donorId: donorId, caseId: caseId);
      } else {
        await repo.addFavoriteCase(donorId: donorId, caseId: caseId);
      }
      // reload من السيرفر بعد النجاح
      await getfav(donorId);
    } catch (e) {
      // لو فشل، رجع للحالة الأصلية
      emit(FavoritSuccess(favorit: currentState.favorit));
    }
  }

  // ✅ هل الحالة دي في المفضلة؟
  bool isFavorite(int caseId) {
    final currentState = state;
    if (currentState is FavoritSuccess) {
      return currentState.favorit.any((e) => e.caseId == caseId);
    }
    return false;
  }
}
