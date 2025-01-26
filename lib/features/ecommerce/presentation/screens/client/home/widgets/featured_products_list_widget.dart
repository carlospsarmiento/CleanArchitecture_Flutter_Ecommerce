import 'package:app_flutter/core/di/di.dart';
import 'package:app_flutter/features/ecommerce/domain/entity/product.dart';
import 'package:app_flutter/features/ecommerce/domain/usecase/get_featured_products.dart';
import 'package:app_flutter/features/ecommerce/presentation/screens/client/home/bloc/featured_products/featured_products_cubit.dart';
import 'package:app_flutter/features/ecommerce/presentation/screens/client/home/bloc/featured_products/featured_products_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeaturedProductsListWidget extends StatelessWidget {
  const FeaturedProductsListWidget({super.key});

    @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FeaturedProductsCubit(di<GetFeaturedProducts>())..getFeaturedProducts(),
      child: BlocBuilder<FeaturedProductsCubit, FeaturedProductsState>(
        builder: (context, state) {
          if (state is FeaturedProductsLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is FeaturedProductsLoaded) {
            return _buildFeaturedProductList(state.products,context);
          }
          if (state is FeaturedProductsError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildFeaturedProductList(List<Product> products,BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Productos Destacados',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text('Ver todo'),
            ),
          ],
        ),
        SizedBox(height: 12),
        SizedBox(
          height: 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return Container(
                width: 160,
                margin: EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Theme.of(context).colorScheme.surface,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                      child: Image.network(
                        product.image??"",
                        height: 120,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.name,
                            style: Theme.of(context).textTheme.titleMedium,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 4),
                          Text(
                            '\$${product.price}',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
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
}