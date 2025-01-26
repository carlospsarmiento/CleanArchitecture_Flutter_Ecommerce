import 'package:app_flutter/core/network/dio_client.dart';
import 'package:app_flutter/core/preferences/app_preferences.dart';
import 'package:app_flutter/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:app_flutter/features/auth/data/datasource/auth_remote_datasource_impl.dart';
import 'package:app_flutter/features/auth/data/repository/auth_repository_impl.dart';
import 'package:app_flutter/features/auth/domain/repository/auth_repository.dart';
import 'package:app_flutter/features/auth/domain/usecase/get_userlogged.dart';
import 'package:app_flutter/features/auth/domain/usecase/login_user.dart';
import 'package:app_flutter/features/auth/domain/usecase/signup_user.dart';
import 'package:app_flutter/features/ecommerce/data/datasource/category/category_remote_datasource.dart';
import 'package:app_flutter/features/ecommerce/data/datasource/category/category_remote_datasource_impl.dart';
import 'package:app_flutter/features/ecommerce/data/datasource/product/product_remote_datasource.dart';
import 'package:app_flutter/features/ecommerce/data/datasource/product/product_remote_datasource_impl.dart';
import 'package:app_flutter/features/ecommerce/data/datasource/special_offer/special_offer_remote_datasource.dart';
import 'package:app_flutter/features/ecommerce/data/datasource/special_offer/special_offer_remote_datasource_impl.dart';
import 'package:app_flutter/features/ecommerce/data/repository/category_repository_impl.dart';
import 'package:app_flutter/features/ecommerce/data/repository/product_repository_impl.dart';
import 'package:app_flutter/features/ecommerce/data/repository/special_offer_repository_impl.dart';
import 'package:app_flutter/features/ecommerce/domain/repository/category_repository.dart';
import 'package:app_flutter/features/ecommerce/domain/repository/product_repository.dart';
import 'package:app_flutter/features/ecommerce/domain/repository/special_offer_repository.dart';
import 'package:app_flutter/features/ecommerce/domain/usecase/get_featured_products.dart';
import 'package:app_flutter/features/ecommerce/domain/usecase/getall_categories.dart';
import 'package:app_flutter/features/ecommerce/domain/usecase/get_all_special_offers.dart';
import 'package:app_flutter/features/ecommerce/presentation/screens/client/home/bloc/categories_display/categories_display_cubit.dart';
import 'package:app_flutter/features/ecommerce/presentation/screens/client/home/bloc/featured_products/featured_products_cubit.dart';
import 'package:app_flutter/features/ecommerce/presentation/screens/client/home/bloc/special_offers/special_offers_cubit.dart';
import 'package:app_flutter/shared/data/datasource/shared_preferences_datasource.dart';
import 'package:app_flutter/shared/data/datasource/shared_preferences_datasource_impl.dart';
import 'package:app_flutter/features/auth/domain/usecase/logout_user.dart';
import 'package:app_flutter/shared/presentation/bloc/auth_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final di = GetIt.instance;

Future<void> initDi() async{

  // globals
  //di.registerSingleton<DioClient>(DioClient());
  di.registerSingleton<DioClient>(DioClient(() => di<AuthRepository>().getToken()));

  final sharedPreferences = await SharedPreferences.getInstance();
  di.registerLazySingleton(() => sharedPreferences);
  di.registerSingleton<AppPreferences>(AppPreferences());

  // data sources
  di.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(di()));
  di.registerLazySingleton<SharedPreferencesDatasource>( () => SharedPreferencesDatasourceImpl(di()));
  di.registerLazySingleton<CategoryRemoteDatasource>(() => CategoryRemoteDatasourceImpl(di()));
  di.registerLazySingleton<SpecialOfferRemoteDataSource>(() => SpecialOfferRemoteDataSourceImpl(di()));
  di.registerLazySingleton<ProductRemoteDatasource>(() => ProductRemoteDatasourceImpl(di()));

  // repositories
  di.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(di(), di()));
  di.registerLazySingleton<CategoryRepository>(() => CategoryRepositoryImpl(di()));
  di.registerLazySingleton<SpecialOfferRepository>(() => SpecialOfferRepositoryImpl(di()));
    di.registerLazySingleton<ProductRepository>(() => ProductRepositoryImpl(di()));

  // use cases
  di.registerLazySingleton<LoginUser>(() => LoginUser(di()));
  di.registerLazySingleton<LogoutUser>(() => LogoutUser(di()));
  di.registerLazySingleton<GetUserLogged>(() => GetUserLogged(di()));
  di.registerLazySingleton<SignupUser>(() => SignupUser(di()));
  di.registerLazySingleton<GetAllCategories>(() => GetAllCategories(di()));
  di.registerLazySingleton<GetAllSpecialOffers>(() => GetAllSpecialOffers(di()));
    di.registerLazySingleton<GetFeaturedProducts>(() => GetFeaturedProducts(di()));

  // cubit
  di.registerFactory(() => AuthCubit(di(), di(), di(), di()));
  di.registerFactory(() => CategoriesDisplayCubit(di()));
  di.registerFactory(() => SpecialOffersCubit(di()));
  di.registerFactory(() => FeaturedProductsCubit(di()));
}