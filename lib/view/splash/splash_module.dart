import 'package:get_it/get_it.dart';
import '../../view/splash/splash_bloc.dart';
import '../../view/splash/splash_view.dart';

class SplashModule {
  static GetIt getIt = GetIt.instance;
  void configure() {
    getIt
      ..registerLazySingleton<ISplashBloc>(() => SplashBloc(getIt(), getIt()))
      ..registerSingleton(() => SplashView(getIt()));
  }
}
