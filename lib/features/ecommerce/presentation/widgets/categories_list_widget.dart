import 'package:app_flutter/core/di/di.dart';
import 'package:app_flutter/features/ecommerce/domain/entity/category.dart';
import 'package:app_flutter/features/ecommerce/domain/usecase/getall_categories.dart';
import 'package:app_flutter/features/ecommerce/presentation/bloc/categories/categories_display_cubit.dart';
import 'package:app_flutter/features/ecommerce/presentation/bloc/categories/categories_display_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesListWidget extends StatelessWidget {
  const CategoriesListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoriesDisplayCubit(di<GetAllCategories>())..displayCategories(),
      child: BlocBuilder<CategoriesDisplayCubit,CategoriesDisplayState>(
        builder: (context,state){
          if(state is CategoriesLoading){
            return const CircularProgressIndicator();
          }
          if(state is CategoriesLoaded){
            return Column(
              children: [
                _seeAll(),
                const SizedBox(height: 16),
                _categories(state.categories)
              ],
            );
          }
          return Container();
        }
      ),
    );
  }

  Widget _seeAll(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Categories"),

      ],
    );
  }

  Widget _categories(List<Category> categories){
    print(categories);
    return Text("Lista de categorias");
  }
}
