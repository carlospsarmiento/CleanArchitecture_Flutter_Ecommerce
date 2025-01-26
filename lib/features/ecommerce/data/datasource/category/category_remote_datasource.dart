import 'package:app_flutter/features/ecommerce/data/model/category_model.dart';

abstract class CategoryRemoteDatasource{
  Future<List<CategoryModel>> getAll();
}