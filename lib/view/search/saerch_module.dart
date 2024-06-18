import 'package:get_it/get_it.dart';

import 'saerch_bloc.dart';
import 'saerch_view.dart';

class SearchModule {
  static GetIt getIt = GetIt.instance;
  void configure() {
    getIt
      ..registerFactory<ISearchBloc>(() => SearchBloc(
            getIt(),
            getIt(),
            getIt(),
          ))
      ..registerFactory(() => SearchView(
            getIt(),
          ));
  }
}
