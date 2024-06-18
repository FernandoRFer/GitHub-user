import 'package:get_it/get_it.dart';
import 'package:open_labs/repository/local_data_storage/search_history_db.dart.dart';
import 'package:open_labs/repository/rest_client/irest_client.dart';
import 'package:open_labs/repository/rest_client/rest_client.dart';
import 'package:open_labs/repository/user_repository/iuser_repository.dart';
import 'package:open_labs/repository/user_repository/user_repository.dart';

class RepositoryModule {
  static GetIt getIt = GetIt.instance;
  void configure() {
    getIt
      ..registerFactory<IRestClient>(() => RestClient())
      ..registerSingleton<IUserRepository>(UserRepository(getIt()))
      ..registerSingleton<IDbHistory>(DbHistory());
  }
}
