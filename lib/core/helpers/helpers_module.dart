import 'package:get_it/get_it.dart';
import 'package:open_labs/core/helpers/global_error.dart';

class HelpersModule {
  static GetIt getIt = GetIt.instance;
  void configure() {
    getIt.registerLazySingleton<IGlobalError>(() => GlobalError());
  }
}
