import 'package:equatable/equatable.dart';
import 'package:waslet_khier/features/profile_feature/data/models/favorite_model/favorite_model.dart';

abstract class FavorieState extends Equatable {
  const FavorieState();

  @override
  List<Object> get props => [];
}

final class FavoritInitial extends FavorieState {}

final class favoritLodaing extends FavorieState {}

final class FavoritSuccess extends FavorieState {
  final List<FavoriteModel> favorit;
  const FavoritSuccess({required this.favorit});
}

final class FavoritFaild extends FavorieState {
  final String errorMessage;

  const FavoritFaild({required this.errorMessage});
}
