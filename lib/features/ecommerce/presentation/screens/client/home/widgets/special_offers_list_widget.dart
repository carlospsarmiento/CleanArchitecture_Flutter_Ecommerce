import 'package:app_flutter/core/di/di.dart';
import 'package:app_flutter/features/ecommerce/domain/entity/special_offer.dart';
import 'package:app_flutter/features/ecommerce/domain/usecase/get_all_special_offers.dart';
import 'package:app_flutter/features/ecommerce/presentation/screens/client/home/bloc/special_offers_cubit.dart';
import 'package:app_flutter/features/ecommerce/presentation/screens/client/home/bloc/special_offers_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';

class SpecialOffersListWidget extends StatelessWidget {
  const SpecialOffersListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SpecialOffersCubit(di<GetAllSpecialOffers>())..getAllSpecialOffers(),
      child: BlocBuilder<SpecialOffersCubit, SpecialOffersState>(
        builder: (context, state) {
          if (state is SpecialOffersLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is SpecialOffersLoadedState) {
            return _buildOffersList(state.offers);
          }
          if (state is SpecialOffersErrorState) {
            return Center(child: Text(state.message));
          }
          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildOffersList(List<SpecialOffer> offers) {
    return SizedBox(
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: offers.length,
        itemBuilder: (context, index) {
          final offer = offers[index];
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: Container(
              width: 300,
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: CachedNetworkImage(
                        imageUrl: offer.imageUrl,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) => const Icon(
                          Icons.error,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    offer.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    offer.description,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
