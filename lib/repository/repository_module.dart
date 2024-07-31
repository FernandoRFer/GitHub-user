import 'package:get_it/get_it.dart';
import 'package:github_user/repository/local%20_file/linguage_color.dart';
import 'package:github_user/repository/local_db/search_history_db.dart.dart';
import 'package:github_user/repository/rest_client/irest_client.dart';
import 'package:github_user/repository/rest_client/rest_client.dart';
import 'package:github_user/repository/token_repository/token_respository.dart';
import 'package:github_user/repository/gihub_repository/igithub_repository.dart';
import 'package:github_user/repository/gihub_repository/gitgub_repository.dart';

import 'local_storage/storage_cache.dart';

class RepositoryModule {
  static GetIt getIt = GetIt.instance;
  void configure() {
    getIt
      ..registerFactory<IRestClient>(() => RestClient())
      ..registerSingleton<IStorageCache>(HiveStorage())
      ..registerSingleton<ITokenReposytory>(TokenReposytory(getIt(), getIt()))
      ..registerSingleton<IGithubRepository>(GithubRepository(getIt(), getIt()))
      ..registerSingleton<IDbHistory>(DbHistory())
      ..registerSingleton<ILinguageColor>(LinguageColor());
  }
}
