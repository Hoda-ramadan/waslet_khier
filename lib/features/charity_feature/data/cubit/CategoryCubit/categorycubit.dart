import 'package:bloc/bloc.dart';
import 'package:waslet_khier/features/charity_feature/data/cubit/CategoryCubit/categoryState.dart';
import 'package:waslet_khier/features/charity_feature/data/models/category_model/category_madel2/category_madel2.dart';
import 'package:waslet_khier/features/charity_feature/data/repo/categoryrepo.dart';

class Categorycubit extends Cubit<CategoryState> {
  final Categoryrepo repo;

  Categorycubit(this.repo) : super(CategoryInitial());

  List<CategoryMadel> category = [];

  Future<void> getCategoriesByCharity(int charityId) async {
    emit(CategoryLoading());
    try {
      final categories = await repo.getCategoriesByCharity(charityId);
      emit(CategorySuccess(categories: categories));
    } catch (e) {
      emit(CategoryFailed(errorMsg: e.toString()));
    }
  }
}
