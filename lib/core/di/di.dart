import 'package:app_flutter/core/network/dio_client.dart';
import 'package:app_flutter/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:app_flutter/features/auth/data/datasource/auth_remote_datasource_impl.dart';
import 'package:app_flutter/features/auth/data/repository/auth_repository_impl.dart';
import 'package:app_flutter/features/auth/domain/repository/auth_repository.dart';
import 'package:app_flutter/features/auth/domain/usecase/login_user.dart';
import 'package:app_flutter/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:get_it/get_it.dart';

final di = GetIt.instance;

Future<void> initDi() async{

  // globals
  di.registerSingleton<DioClient>(DioClient());

  // data sources
  di.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(di()));

  // repositories
  di.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(di()));

  // use cases
  di.registerLazySingleton<LoginUser>(() => LoginUser(di()));

  // cubit
  di.registerFactory(() => AuthCubit(di()));
}