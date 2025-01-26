import 'package:app_flutter/core/di/di.dart';
import 'package:app_flutter/features/ecommerce/domain/entity/category.dart';
import 'package:app_flutter/features/ecommerce/domain/usecase/getall_categories.dart';
import 'package:app_flutter/features/ecommerce/presentation/screens/client/home/bloc/categories_display/categories_display_cubit.dart';
import 'package:app_flutter/features/ecommerce/presentation/screens/client/home/bloc/categories_display/categories_display_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ClientCategoriesScreen extends StatelessWidget {
  const ClientCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60), // Altura personalizada
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0, // Sin sombra
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: Colors.grey.shade200, // Fondo del botón
              child: IconButton(
                icon: Icon(Icons.chevron_left, color: Colors.black), // Ícono de retroceder
                onPressed: () {
                  Navigator.pop(context); // Acción al presionar el botón
                },
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Todas las Categorías',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: BlocProvider(
                create: (context) => CategoriesDisplayCubit(di<GetAllCategories>())..displayCategories(),
                child: BlocBuilder<CategoriesDisplayCubit,CategoriesDisplayState>(
                  builder: (context, state) {
                    if(state is CategoriesLoading){
                       return Center(child:CircularProgressIndicator());
                    }else if (state is CategoriesLoaded){
                      final categories = state.categories;
                      return ListView.separated(
                        itemCount: categories.length,
                        separatorBuilder: (context, index) => const SizedBox(height: 8.0),
                        itemBuilder: (context, index) {
                          final category = categories[index];
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  if (category.image != null && category.image!.isNotEmpty)
                                    CircleAvatar(
                                      backgroundImage: NetworkImage(category.image!),
                                      radius: 30,
                                    ),
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text(category.name),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return const Center(child: Text('No categories found.'));
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<List<Category>> getCategories() async {
    // Replace with your actual category fetching logic. This is a placeholder.
    await Future.delayed(const Duration(seconds: 2));
    return [
      Category(name: 'Electronics', description: 'Smartphones, TVs, Laptops', image: 'https://via.placeholder.com/150'),
      Category(name: 'Clothing', description: 'Shirts, Pants, Dresses', image: 'https://via.placeholder.com/150'),
      Category(name: 'Books', description: 'Fiction, Non-fiction, Textbooks', image: 'https://via.placeholder.com/150'),
    ];
  }
}
