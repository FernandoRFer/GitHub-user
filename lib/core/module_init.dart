import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:github_user/core/helpers/helpers_module.dart';
import 'package:github_user/core/navigator_app.dart';
import 'package:github_user/repository/repository_module.dart';
import 'package:github_user/view/view_module.dart';

class AppModule {
  final GlobalKey<NavigatorState> navigatorKey;
  AppModule(
    this.navigatorKey,
  );
  static GetIt getIt = GetIt.instance;

  void configure() {
    ViewModule().configure();
    HelpersModule().configure();
    RepositoryModule().configure();

    getIt
        .registerLazySingleton<INavigatorApp>(() => NavigatorApp(navigatorKey));
  }
}
