import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waslet_khier/features/profile_feature/data/favCubit/favstate.dart';
import 'package:waslet_khier/features/profile_feature/data/favrepo/FavoriteRepo.dart';
import 'package:waslet_khier/features/profile_feature/data/models/favorite_model/favorite_model.dart';

class Favcubit extends Cubit<FavorieState> {
  final Favoriterepo repo;
  List<FavoriteModel> _cachedcases = [];

  Favcubit(this.repo) : super(FavoritInitial());

  Future<void> getfav() async {
    if (_cachedcases.isNotEmpty) {
      emit(FavoritSuccess(favorit: _cachedcases));
      return;
    }

    emit(favoritLodaing());
    try {
      final result = await repo.getFavoritcase();
      _cachedcases = result;
      emit(FavoritSuccess(favorit: result));
    } catch (e) {
      emit(FavoritFaild(errorMessage: e.toString()));
    }
  }
}
