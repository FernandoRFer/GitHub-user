import 'package:get_it/get_it.dart';
import 'auth_bloc.dart';
import 'auth_view.dart';

class AuthModule {
  static GetIt getIt = GetIt.instance;
  void configure() {
    getIt
      ..registerFactory<IAuthBloc>(() => AuthBloc(
            getIt(),
            getIt(),
            getIt(),
          ))
      ..registerFactory(() => AuthView(getIt()));
  }
}
