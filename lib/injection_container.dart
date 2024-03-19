import 'package:_/core/network/network_info.dart';
import 'package:_/features/posts/data/data_sources/local_data_source.dart';

import 'package:_/features/posts/data/data_sources/remote_data_source.dart';
import 'package:_/features/posts/data/repositories/post_repository_imp.dart';
import 'package:_/features/posts/domain/repositories/post_repository.dart';
import 'package:_/features/posts/domain/use_cases/add_post.dart';
import 'package:_/features/posts/domain/use_cases/delete_post.dart';
import 'package:_/features/posts/domain/use_cases/get_all_post.dart';
import 'package:_/features/posts/domain/use_cases/update_post.dart';
import 'package:_/features/posts/prestations/bloc/add_delete_update_post.dart/bloc/add_delete_update_bloc.dart';
import 'package:_/features/posts/prestations/bloc/posts/post_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //////////////FETURES = posts

//Bloc
  sl.registerFactory(() => PostBloc(getAllPost: sl()));
  sl.registerFactory(() => AddDeleteUpdateBloc(
      addPostUseCase: sl(), updatePostUseCase: sl(), deletePostUseCase: sl()));

//UseCase
  sl.registerLazySingleton(() => GetAllPostUseCase(sl()));
  sl.registerLazySingleton(() => AddPostUseCase(sl()));
  sl.registerLazySingleton(() => UpdatePostUseCase(sl()));
  sl.registerLazySingleton(() => DeletePostUseCase(sl()));

//Repository
  sl.registerLazySingleton<PostRepository>(() => PostRepoSitoryImp(
      remoteDataSource: sl(), networkInfo: sl(), localDataSource: sl()));
//DataSources
  sl.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImp(client: sl()));
  sl.registerLazySingleton<LocalDataSource>(
      () => LocalDataSaourceImp(sharedPreferences: sl()));

/////////////Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImp(sl()));
  /////////////External
  final shredPrefrences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => shredPrefrences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
