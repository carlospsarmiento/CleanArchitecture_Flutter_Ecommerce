import 'package:app_flutter/core/di/di.dart';
import 'package:app_flutter/features/ecommerce/domain/entity/category.dart';
import 'package:app_flutter/features/ecommerce/domain/usecase/getall_categories.dart';
import 'package:app_flutter/features/ecommerce/presentation/screens/client/home/bloc/categories_display_cubit.dart';
import 'package:app_flutter/features/ecommerce/presentation/screens/client/home/bloc/categories_display_state.dart';
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
            /*
            return Column(
              children: [
                _seeAll(),
                const SizedBox(height: 16),
                _categories(state.categories)
              ],
            );
            */

            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Título y botón "Ver todos"
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Categorías',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // Acción al presionar "Ver todos"
                        },
                        child: Text(
                          'Ver todos',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  // Lista horizontal de categorías
                  SizedBox(
                    height: 100, // Altura para acomodar las imágenes y texto
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.categories.length,
                      itemBuilder: (context, index) {
                        final category = state.categories[index];
                        return Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: Column(
                            children: [
                              // Imagen circular
                              CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage("https://www.lomas.pe/cdn/shop/files/IMG_0934.jpg"),
                              ),
                              const SizedBox(height: 4.0),
                              // Nombre de la categoría
                              Text(
                                category.name,
                                style: Theme.of(context).textTheme.bodySmall,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
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
