import 'package:app_flutter/core/di/di.dart';
import 'package:app_flutter/features/ecommerce/domain/usecase/getall_categories.dart';
import 'package:app_flutter/features/ecommerce/presentation/screens/client/home/bloc/categories_display/categories_display_cubit.dart';
import 'package:app_flutter/features/ecommerce/presentation/screens/client/home/bloc/categories_display/categories_display_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                        onPressed: () {},
                        child: Text('Ver todo'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.categories.length,
                      itemBuilder: (context, index) {
                        final category = state.categories[index];
                        return Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: Column(
                            children: [
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Theme.of(context).colorScheme.surface,
                                ),
                                child: ClipOval(
                                  child: category.image != null && category.image!.isNotEmpty
                                      ? Image.network(
                                          category.image!,
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, error, stackTrace) => 
                                            SvgPicture.asset(
                                              'assets/svg/default_category.svg',
                                              width: 30,
                                              height: 30,
                                              colorFilter: ColorFilter.mode(
                                                Theme.of(context).colorScheme.primary,
                                                BlendMode.srcIn,
                                              ),
                                            ),
                                        )
                                      : SvgPicture.asset(
                                          'assets/svg/default_category.svg',
                                          width: 30,
                                          height: 30,
                                          colorFilter: ColorFilter.mode(
                                            Theme.of(context).colorScheme.primary,
                                            BlendMode.srcIn,
                                          ),
                                        ),
                                ),
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
}
