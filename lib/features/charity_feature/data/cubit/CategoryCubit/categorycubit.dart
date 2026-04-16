import 'package:bloc/bloc.dart';
import 'package:waslet_khier/features/charity_feature/data/cubit/CategoryCubit/categoryState.dart';
import 'package:waslet_khier/features/charity_feature/data/models/category_model/category_model.dart';

import 'package:waslet_khier/features/charity_feature/data/repo/categoryrepo.dart';

class Categorycubit extends Cubit<Categorystate> {
  final Categoryrepo repo;

  Categorycubit(this.repo) : super(InitialCategory());

  List<CategoryModel> category = [];

  Future<void> getCategory() async {
    emit(loadingCategory());
    try {
      category = await repo.getCategory();
      emit(SuccessCategory(categorymodel: category));
    } catch (e) {
      emit(FaildCategory(errormsg: e.toString()));
    }
  }
}
