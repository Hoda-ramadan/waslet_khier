import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:waslet_khier/core/api/api_service.dart';
import 'package:waslet_khier/features/charity_feature/data/cubit/CategoryCubit/categoryState.dart';
import 'package:waslet_khier/features/charity_feature/data/models/category_model/category_model.dart';
import 'package:waslet_khier/features/charity_feature/data/repo/categoryrepo.dart';

class Categorycubit extends Cubit<Categorystate> {
  Categorycubit() : super(InitialCategory());
  List<CategoryModel> category = [];

  Future<void> getCategory() async {
    emit(loadingCategory());
    try {
      var data = await Categoryrepo(ApiService(Dio())).getCategory();
      category = data;
      emit(SuccessCategory(categorymodel: category));
    } catch (e) {
      emit(FaildCategory(errormsg: e.toString()));
    }
  }
}
