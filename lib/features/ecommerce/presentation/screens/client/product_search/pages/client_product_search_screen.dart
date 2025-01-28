import 'package:app_flutter/core/di/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_flutter/features/ecommerce/domain/usecase/search_products.dart';
import 'package:app_flutter/features/ecommerce/domain/entity/product.dart';
import 'package:app_flutter/features/ecommerce/presentation/bloc/product_search/product_search_cubit.dart';
import 'package:app_flutter/features/ecommerce/presentation/bloc/product_search/product_search_state.dart';

class ClientProductSearchScreen extends StatelessWidget {

  ClientProductSearchScreen({super.key});

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductSearchCubit(di<SearchProducts>())..searchProducts(searchController.text),
      child: Builder(
        builder: (context) {
          final cubit = context.read<ProductSearchCubit>();
          return Scaffold(
            appBar: AppBar(
              title: _searchBar(cubit),
            ),
            body: BlocBuilder<ProductSearchCubit, ProductSearchState>(
              builder: (context, state) {
                if (state is ProductSearchInitial) {
                  return const Center(
                    child: Text('Ingresa un término para buscar productos.'),
                  );
                } else if (state is ProductSearchLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is ProductSearchLoaded) {
                  return _ProductGrid(products: state.products);
                } else if (state is ProductSearchError) {
                  return Center(
                    child: Text(
                      state.message,
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          );
        }
      ),
    );
  }

  _searchBar(ProductSearchCubit cubit){
    return TextField(
      controller: searchController,
      autofocus: true,
      decoration: InputDecoration(
        hintText: 'Buscar productos...',
        border: InputBorder.none,
        suffixIcon: IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            cubit.searchProducts(searchController.text);
          },
        ),
      ),
      onSubmitted: (value) {
        cubit.searchProducts(value);
      },
    );
  }
}

class _ProductGrid extends StatelessWidget {
  final List<Product> products;

  const _ProductGrid({required this.products});

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return const Center(
        child: Text('No se encontraron productos.'),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16.0,
          crossAxisSpacing: 16.0,
          childAspectRatio: 0.75,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return _ProductCard(
            name: product.name,
            price: product.price,
            imageUrl: product.image ??
                'https://via.placeholder.com/150', // Imagen por defecto
          );
        },
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  final String name;
  final String price;
  final String imageUrl;

  const _ProductCard({
    required this.name,
    required this.price,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              name,
              style: Theme.of(context).textTheme.bodyMedium,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              '\$${price}',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: Theme.of(context).colorScheme.primary),
            ),
          ),
        ],
      ),
    );
  }
}