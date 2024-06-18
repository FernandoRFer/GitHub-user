import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:open_labs/view/home/home_view.dart';
import 'package:open_labs/view/search/Saerch_view.dart';
import 'package:open_labs/view/search/saerch_bloc.dart';
import 'package:open_labs/view/splash/splash_bloc.dart';
import 'package:open_labs/view/splash/splash_view.dart';
import 'custon_page_router.dart';

class AppRoutes {
  static const String initial = splash;
  static const String home = "/home";
  static const String splash = "/splash";
  static const String search = "/search";

  static GetIt getIt = GetIt.I;

  static Map<String, WidgetBuilder> get routes => {
        splash: (_) => SplashView(getIt.get<ISplashBloc>()),
        // home: (_) => getIt.get<HomeView>(),
        search: (_) => SearchView(getIt.get<ISearchBloc>()),
      };

  static Route? onGenerateRoutes(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case home:
        return CustonPageRouter(
            child: getIt.get<HomeView>(), settings: routeSettings);
      default:
        return null;
    }
  }
}
