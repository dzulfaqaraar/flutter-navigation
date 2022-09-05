import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'data/datasources/local_data_source.dart';
import 'data/datasources/remote_data_source.dart';
import 'data/repositories/repository_impl.dart';
import 'domain/repositories/repository.dart';
import 'domain/usecases/check_session.dart';
import 'domain/usecases/get_user.dart';
import 'domain/usecases/logout_user.dart';
import 'domain/usecases/post_login.dart';

final locator = GetIt.instance;

void init() {
  // use case
  locator.registerLazySingleton(() => CheckSession(repository: locator()));
  locator.registerLazySingleton(() => PostLogin(repository: locator()));
  locator.registerLazySingleton(() => GetUser(repository: locator()));
  locator.registerLazySingleton(() => LogoutUser(repository: locator()));

  // repository
  locator.registerLazySingleton<Repository>(
    () => RepositoryImpl(
      localDataSource: locator<LocalDataSource>(),
      remoteDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<LocalDataSource>(
      () => LocalDataSourceImpl.instance());
  locator.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(client: locator()));

  // http
  locator.registerLazySingleton(() => http.Client());
}
