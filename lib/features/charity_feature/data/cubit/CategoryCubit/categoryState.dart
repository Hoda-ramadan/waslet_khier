import 'package:waslet_khier/features/charity_feature/data/models/category_model/category_model.dart';

abstract class Categorystate {}

class InitialCategory extends Categorystate {}

class loadingCategory extends Categorystate {}

class SuccessCategory extends Categorystate {
  final List<CategoryModel> categorymodel;

  SuccessCategory({required this.categorymodel});
}

class FaildCategory extends Categorystate {}
