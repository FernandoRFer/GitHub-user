import 'package:flutter/material.dart';
import 'package:open_labs/core/helpers/global_error.dart';
import 'package:open_labs/core/navigator_app.dart';
import 'package:open_labs/repository/local_db/search_history_db.dart.dart';
import 'package:open_labs/repository/model/search_history_model.dart';
import 'package:open_labs/view/view_state_entity.dart';
import 'package:rxdart/rxdart.dart';

class SearchModelBloc extends ViewStateEntity {
  List<SearchHistoryModel>? searchHistory;
  SearchModelBloc(
    super.state, {
    super.isLoading,
    this.searchHistory,
  });
}

abstract class ISearchBloc {
  Stream<SearchModelBloc> get onFetchingData;
  Future<void> loadingHistory();
  void navigatorPop();
  Future<void> dispose();
  void navigatorPopGetUserName(String userName);
  Future<void> deleteHistory(int id);
}

class SearchBloc extends ChangeNotifier implements ISearchBloc {
  final IGlobalError _globalError;
  final INavigatorApp _navigatorApp;
  final IDbHistory _dbHistory;

  SearchBloc(
    this._globalError,
    this._navigatorApp,
    this._dbHistory,
  );

  final _fetchingDataController = BehaviorSubject<SearchModelBloc>();

  @override
  Future<void> dispose() async {
    await _fetchingDataController.close();
    super.dispose();
  }

  @override
  Future<void> loadingHistory() async {
    try {
      _fetchingDataController
          .add(SearchModelBloc("Carregando ", isLoading: false));
      final result = await _dbHistory.get();
      _fetchingDataController.add(SearchModelBloc("Concluido",
          isLoading: false, searchHistory: result));
    } catch (e) {
      final error = await _globalError.errorHandling(
        "Um erro ocorreu ao carregar dados locais, tente novamente",
        e,
      );
      _fetchingDataController.addError(
        error.message,
      );
    }
  }

  @override
  Future<void> deleteHistory(int id) async {
    try {
      await _dbHistory.remove(id);
      final result = await _dbHistory.get();
      _fetchingDataController.add(SearchModelBloc("removido com sucesso",
          isLoading: false, searchHistory: result));
    } catch (e) {
      final error = await _globalError.errorHandling(
        "Um erro ocorreu ao apagar dados do histórico, tente novamente",
        e,
      );
      _fetchingDataController.addError(
        error.message,
      );
    }
  }

  @override
  void navigatorPop() {
    _fetchingDataController.add(SearchModelBloc(
      "donel",
      isLoading: false,
    ));
    _navigatorApp.pop();
  }

  @override
  void navigatorPopGetUserName(String userName) {
    _navigatorApp.pop(userName);
  }

  @override
  Stream<SearchModelBloc> get onFetchingData => _fetchingDataController.stream;
}
