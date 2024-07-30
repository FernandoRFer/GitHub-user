import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:flutter/foundation.dart';
import 'package:github_user/core/helpers/global_error.dart';
import 'package:github_user/core/navigator_app.dart';
import 'package:github_user/core/router/routes.dart';
import 'package:github_user/repository/token_repository/token_respository.dart';
import 'package:github_user/view/view_state_entity.dart';
import 'package:rxdart/rxdart.dart';
import 'package:url_launcher/url_launcher.dart';

class AuthModelBloc extends ViewStateEntity {
  bool isStayConnected;

  AuthModelBloc(
    super.state, {
    super.isLoading,
    this.isStayConnected = false,
  });
}

abstract class IAuthBloc {
  Stream<AuthModelBloc> get onFetchingData;
  Future<void> loginWeb();
  Future<void> dispose();
  void stayConnected();
  void navigatePop();
}

class AuthBloc extends ChangeNotifier implements IAuthBloc {
  final IGlobalError _globalError;
  final INavigatorApp _navigatorApp;
  final ITokenReposytory _tokenReposytory;

  final _fetchingDataController = BehaviorSubject<AuthModelBloc>();
  bool _isStayConnected = false;
  final appLinks = AppLinks();

  late StreamSubscription<Uri>? _linkSubscription;

  AuthBloc(
    this._globalError,
    this._navigatorApp,
    this._tokenReposytory,
  );

  @override
  Future<void> dispose() async {
    await _fetchingDataController.close();

    super.dispose();
  }

  @override
  Future<void> loginWeb() async {
    try {
      _fetchingDataController.add(AuthModelBloc("Loading",
          isLoading: true, isStayConnected: _isStayConnected));

      _openAppLink();

      var uri = Uri.parse("https://github.com/login/oauth/authorize")
          .resolveUri(Uri(queryParameters: {
        "reponse_type": "code",
        "state": "fernando",
        "client_id": ClienData.clientId,
        "scope": "repo,user",
        "redirect_uri": "https://fernandorfer.github.io",
      }));

      await launchUrl(
        uri,
      );

      _fetchingDataController.add(AuthModelBloc("Done",
          isLoading: false, isStayConnected: _isStayConnected));
    } catch (e) {
      final error = await _globalError.errorHandling(
        "Um erro  ocorreu ao conectar, tente novamente",
        e,
      );
      _fetchingDataController.addError(
        error,
      );
    }
  }

  Future<void> _incomingLinkHandler(Uri uri) async {
    try {
      final queryParametersAll = (uri.queryParametersAll);
      if (queryParametersAll.containsKey('error')) {
        final error = await _globalError.errorHandling(
          "Um erro ocorreu ao conectar, tente novamente",
          queryParametersAll,
        );
        _fetchingDataController.addError(
          error,
        );
      } else {
        if (queryParametersAll.containsKey('code')) {
          _linkSubscription!.cancel();
          final authentication = queryParametersAll['code'];
          await _tokenReposytory.create(authentication![0]);
          _navigatorApp.pushNamed(AppRoutes.home);
        }
      }
    } catch (e) {
      final error = await _globalError.errorHandling(
        "",
        e,
      );
      _fetchingDataController.addError(
        error,
      );
    }
  }

  Future<void> _openAppLink() async {
    try {
      _linkSubscription = appLinks.uriLinkStream.listen((uri) async {
        _incomingLinkHandler(uri);
      }, onError: (e) {
        _linkSubscription!.cancel();
      });
    } catch (e) {
      final error = await _globalError.errorHandling(
        "Um erro  ocorreu ao conectar, tente novamente",
        e,
      );
      _fetchingDataController.addError(
        error,
      );
    }
  }

  @override
  void navigatePop() {
    _fetchingDataController.add(AuthModelBloc("Loading",
        isLoading: false, isStayConnected: _isStayConnected));
    _navigatorApp.pop();
  }

  @override
  void stayConnected() {
    _isStayConnected = !_isStayConnected;
    _fetchingDataController.add(AuthModelBloc("done",
        isLoading: false, isStayConnected: _isStayConnected));
  }

  @override
  Stream<AuthModelBloc> get onFetchingData => _fetchingDataController.stream;
}
