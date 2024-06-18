import 'dart:developer';

import 'package:flutter/widgets.dart';

class GlobalRouteObserver extends NavigatorObserver {
  static List<String> routeStack = [];

  @override
  void didPop(Route route, Route? previousRoute) {
    if (route.settings.name != null) {
      routeStack.removeLast();
      navigationTreeRegistration(ENavigatorActions.pop);
    }
  }

  @override
  void didStartUserGesture(Route route, Route? previousRoute) {
    print("TesteGesture");
  }

  @override
  void didStopUserGesture() {
    print("TesteGesture");
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    if (route.settings.name != null) {
      routeStack.add(route.settings.name!);
      navigationTreeRegistration(
          ENavigatorActions.pushNamed, route.settings.name);
    }
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    if (previousRoute != null) {
      routeStack.removeLast();
    }
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    if (oldRoute != null) {
      routeStack.removeLast();
    }
    if (newRoute != null && newRoute.settings.name != null) {
      routeStack.add(newRoute.settings.name!);
      navigationTreeRegistration(
          ENavigatorActions.pushReplacementNamed, newRoute.settings.name!);
    }
  }

  void navigationTreeRegistration(ENavigatorActions action,
      [String? routeName]) {
    final appTree = GlobalRouteObserver.routeStack.join("");

    // implementacao de LOG

    log("NAVIGATOR: ACTION: ${_getActionName(action)} | ROUTENAME: $routeName | ROUTETREE: $appTree");
  }
}

enum ENavigatorActions {
  pop,
  pushNamed,
  pushReplacementNamed,
  popAndPushNamed,
  popUntil,
}

Map<ENavigatorActions, String> _actionNames = {
  ENavigatorActions.pop: "Pop",
  ENavigatorActions.pushNamed: "PushNamed",
  ENavigatorActions.pushReplacementNamed: "PushReplacementNamed",
  ENavigatorActions.popAndPushNamed: "PopAndPushNamed",
  ENavigatorActions.popUntil: "PopUntil",
};

String _getActionName(ENavigatorActions action) {
  if (_actionNames.containsKey(action)) {
    return _actionNames[action] ?? "";
  }
  return "";
}
