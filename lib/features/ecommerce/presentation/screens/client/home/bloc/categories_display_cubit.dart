import 'package:app_flutter/features/ecommerce/domain/usecase/getall_categories.dart';
import 'package:app_flutter/features/ecommerce/presentation/screens/client/home/bloc/categories_display_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesDisplayCubit extends Cubit<CategoriesDisplayState>{

  final GetAllCategories _getAllCategories;

  CategoriesDisplayCubit(this._getAllCategories): super(CategoriesLoading());

  void displayCategories() async{
    final result = await _getAllCategories.call();
    result.fold(
        (failure){
          String errorMessage = failure.message??"";
          emit(CategoriesFailure(message: errorMessage));
        },
        (categories){
          emit(CategoriesLoaded(categories: categories));
        });
  }
}