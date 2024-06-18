import 'dart:developer';

import 'package:flutter/widgets.dart';
import '../core/router/navigator_observer.dart';

abstract class INavigatorApp {
  Future<T?> pushReplacementNamed<T extends Object, TO extends Object>(
      String routeName,
      {TO? result,
      Object? arguments});

  Future<T?> pushNamed<T extends Object>(String routeName, {Object? arguments});

  Future<T?> popAndPushNamed<T extends Object>(String routeName,
      {Object? arguments});

  void popUntil(String routeName);
  void pop<T extends Object>([T? result]);

  String? currentRoute();

  BuildContext? get currentContext;
}

class NavigatorApp implements INavigatorApp {
  final GlobalKey<NavigatorState> navigatorKey;

  NavigatorApp(
    this.navigatorKey,
  );

  @override
  Future<T?> pushReplacementNamed<T extends Object, TO extends Object>(
      String routeName,
      {TO? result,
      Object? arguments}) async {
    try {
      return await navigatorKey.currentState!.pushReplacementNamed(routeName,
          result: result, arguments: arguments);
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  @override
  Future<T?> pushNamed<T extends Object>(String routeName,
      {Object? arguments}) async {
    try {
      return await navigatorKey.currentState!
          .pushNamed(routeName, arguments: arguments);
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  @override
  void pop<T extends Object>([T? result]) {
    try {
      navigatorKey.currentState?.pop(result);
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  void popUntil(String routeName) {
    try {
      navigatorKey.currentState?.popUntil(ModalRoute.withName(routeName));
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Future<T?> popAndPushNamed<T extends Object>(String routeName,
      {Object? arguments}) async {
    try {
      return navigatorKey.currentState
          ?.popAndPushNamed(routeName, arguments: arguments);
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  @override
  BuildContext? get currentContext => navigatorKey.currentContext;

  @override
  String? currentRoute() {
    return GlobalRouteObserver.routeStack.last;
  }
}
