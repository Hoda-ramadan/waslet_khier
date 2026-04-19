// category_state.dart
import 'package:equatable/equatable.dart';
import 'package:waslet_khier/features/charity_feature/data/models/category_model/category_madel2/category_madel2.dart';

abstract class CategoryState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategorySuccess extends CategoryState {
  final List<CategoryMadel> categories;
  CategorySuccess({required this.categories});

  @override
  List<Object?> get props => [categories];
}

class CategoryFailed extends CategoryState {
  final String errorMsg;
  CategoryFailed({required this.errorMsg});

  @override
  List<Object?> get props => [errorMsg];
}
