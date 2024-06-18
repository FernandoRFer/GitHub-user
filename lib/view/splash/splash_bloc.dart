import 'package:flutter/foundation.dart';
import 'package:open_labs/core/helpers/global_error.dart';
import 'package:open_labs/core/navigator_app.dart';
import 'package:open_labs/view/view_state_entity.dart';
import 'package:rxdart/rxdart.dart';
import '../../core/router/routes.dart';

class SplashModel extends ViewStateEntity {
  SplashModel(
    super.state, {
    super.isLoading,
  });
}

abstract class ISplashBloc {
  Stream<SplashModel> get onFetchingData;
  Future<void> load();
  Future<void> dispose();
  void navigatorPop();
}

class SplashBloc extends ChangeNotifier implements ISplashBloc {
  final _streamController = BehaviorSubject<SplashModel>();
  final IGlobalError _globalError;
  final INavigatorApp _navigatorApp;

  SplashBloc(
    this._navigatorApp,
    this._globalError,
  );

  @override
  Future<void> dispose() async {
    super.dispose();
    await _streamController.close();
  }

  @override
  Future<void> load() async {
    try {
      await Future.delayed(const Duration(seconds: 3));

      _navigatorApp.pushReplacementNamed(AppRoutes.home);
    } catch (e) {
      final error = await _globalError.errorHandling(
        "Um erro  ocorreu ao conectar, tente novamente",
        e,
      );
      _streamController.addError(
        error.message,
      );
    }
  }

  @override
  void navigatorPop() {
    _navigatorApp.pop();
  }

  @override
  Stream<SplashModel> get onFetchingData => _streamController.stream;
}
