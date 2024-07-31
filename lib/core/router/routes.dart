import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:github_user/view/auth/auth_view.dart';
import 'package:github_user/view/home/home_view.dart';
import 'package:github_user/view/search/Saerch_view.dart';
import 'package:github_user/view/search/saerch_bloc.dart';
import 'package:github_user/view/splash/splash_bloc.dart';
import 'package:github_user/view/splash/splash_view.dart';
import 'custon_page_router.dart';

class AppRoutes {
  static const String initial = splash;
  static const String home = "/home";
  static const String splash = "/splash";
  static const String search = "/search";

  static const String auth = "/auth";

  static GetIt getIt = GetIt.I;

  static Map<String, WidgetBuilder> get routes => {
        splash: (_) => SplashView(getIt.get<ISplashBloc>()),
        home: (_) => getIt.get<HomeView>(),
        search: (_) => SearchView(getIt.get<ISearchBloc>()),
        auth: (_) => getIt.get<AuthView>(),
      };

  static Route? onGenerateRoutes(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      // case home:
      //   return CustonPageRouter(
      //       child: getIt.get<HomeView>(), settings: routeSettings);
      default:
        return null;
    }
  }
}
