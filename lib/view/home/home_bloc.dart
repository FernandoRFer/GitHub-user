// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:github_user/repository/local%20_file/linguage_color.dart';
import 'package:github_user/repository/model/logged_user_model.dart';
import 'package:github_user/repository/model/user_repos_model.dart';
import 'package:rxdart/rxdart.dart';

import 'package:github_user/core/helpers/global_error.dart';
import 'package:github_user/core/navigator_app.dart';
import 'package:github_user/core/router/routes.dart';
import 'package:github_user/repository/local_db/search_history_db.dart.dart';
import 'package:github_user/repository/model/search_history_model.dart';
import 'package:github_user/repository/gihub_repository/igithub_repository.dart';
import 'package:github_user/repository/model/user_model.dart';
import 'package:github_user/view/view_state_entity.dart';

class HomeModelBloc extends ViewStateEntity {
  LoggedUserModel? user;
  List<UserReposModel?> userReposModel;
  FilterModel? filter;
  bool visibleFilter;
  HomeModelBloc(
    super.state, {
    super.isLoading,
    this.userReposModel = const [],
    this.user,
    this.filter,
    this.visibleFilter = false,
  });
}

class FilterModel {
  bool visibleUserLocation;
  bool visibleProgrammingLanguage;
  bool visibleNumberOfFollowers;
  bool visibleNumberOfRepositories;

  FilterModel({
    this.visibleUserLocation = false,
    this.visibleProgrammingLanguage = false,
    this.visibleNumberOfFollowers = false,
    this.visibleNumberOfRepositories = false,
  });

  FilterModel copyWith({
    bool? visibleUserLocation,
    bool? visibleProgrammingLanguage,
    bool? visibleNumberOfFollowers,
    bool? visibleNumberOfRepositories,
  }) {
    return FilterModel(
      visibleUserLocation: visibleUserLocation ?? this.visibleUserLocation,
      visibleProgrammingLanguage:
          visibleProgrammingLanguage ?? this.visibleProgrammingLanguage,
      visibleNumberOfFollowers:
          visibleNumberOfFollowers ?? this.visibleNumberOfFollowers,
      visibleNumberOfRepositories:
          visibleNumberOfRepositories ?? this.visibleNumberOfRepositories,
    );
  }
}

abstract class IHomeBloc {
  Stream<HomeModelBloc> get onFetchingData;
  Stream<String> get onUserName;
  Future<void> load();
  void navigatorPop();
  Future<void> dispose();
  Future<void> getUserName(String userName);
  Future<void> navigatorSearch();
  void setUserLocation(bool visibleUserLocation);
  void setNumberOfFollowers(bool visibleNumberOfFollowers);
  void setNumberOfRepositories(bool visibleNumberOfRepositories);
  void visibleFilter();
  void setProgrammingLanguage(bool visibleProgrammingLanguage);
}

class HomeBloc extends ChangeNotifier implements IHomeBloc {
  final IGlobalError _globalError;
  final INavigatorApp _navigatorApp;
  final IGithubRepository _userRepository;
  final IDbHistory _dbHistory;

  HomeBloc(
    this._globalError,
    this._navigatorApp,
    this._userRepository,
    this._dbHistory,
  ) {
    _userNameController.add("Pesquisar");
  }

  final _fetchingDataController = BehaviorSubject<HomeModelBloc>();
  final _userNameController = BehaviorSubject<String>();
  LoggedUserModel? _user;

  final List<UserReposModel?> _userReposModel = [];
  FilterModel _filterModel = FilterModel();
  bool _visibleFilter = false;

  @override
  Future<void> dispose() async {
    await _fetchingDataController.close();
    await _userNameController.close();
    super.dispose();
  }

  @override
  Future<void> load() async {
    try {
      _fetchingDataController.add(HomeModelBloc("Loading", isLoading: true));
      //Inicializando lista de cor para liguagens de programação
      await LinguageColor().initList();
      _user = await _userRepository.getLoggedUser();
      final userRepos = await _userRepository.repos();
      if (userRepos.isNotEmpty) _userReposModel.addAll(userRepos);
      _fetchingDataController.add(HomeModelBloc("concluido",
          isLoading: false,
          user: _user,
          userReposModel: _userReposModel,
          filter: _filterModel,
          visibleFilter: _visibleFilter));
    } catch (e) {
      final error = await _globalError.errorHandling(
        "Um erro ocorreu ao conectar, tente novamente",
        e,
      );
      _fetchingDataController.addError(
        error,
      );
    }
  }

  @override
  Future<void> getUserName(String userName) async {
    try {
      _fetchingDataController.add(HomeModelBloc("Loading", isLoading: true));

      _user = await _userRepository.getUser(userName);

      await _dbHistory.insert(SearchHistoryModel(
          searchWord: userName,
          dateTime: DateTime.now().microsecondsSinceEpoch));
      _fetchingDataController.add(HomeModelBloc("concluido",
          isLoading: false,
          user: _user,
          filter: _filterModel,
          visibleFilter: _visibleFilter));
    } catch (e) {
      final globalError = await _globalError.errorHandling(
          "Erro ao buscar usuarios", e, StackTrace.current);
      _fetchingDataController.addError(globalError);
    }
  }

  @override
  Future<void> navigatorSearch() async {
    final result = await _navigatorApp.pushNamed(AppRoutes.search) as String;
    if (result.isNotEmpty) {
      _userNameController.add(result);
      await getUserName(result);
    }
    log(result.toString());
  }

  @override
  void setUserLocation(bool visibleUserLocation) {
    _filterModel =
        _filterModel.copyWith(visibleUserLocation: visibleUserLocation);
    _fetchingDataController.add(HomeModelBloc("concluido",
        isLoading: false,
        user: _user,
        filter: _filterModel,
        visibleFilter: _visibleFilter));
  }

  @override
  void setNumberOfFollowers(bool visibleNumberOfFollowers) {
    _filterModel = _filterModel.copyWith(
        visibleNumberOfFollowers: visibleNumberOfFollowers);
    _fetchingDataController.add(HomeModelBloc("concluido",
        isLoading: false,
        user: _user,
        filter: _filterModel,
        visibleFilter: _visibleFilter));
  }

  @override
  void setNumberOfRepositories(bool visibleNumberOfRepositories) {
    _filterModel = _filterModel.copyWith(
        visibleNumberOfRepositories: visibleNumberOfRepositories);
    _fetchingDataController.add(HomeModelBloc("concluido",
        isLoading: false,
        user: _user,
        filter: _filterModel,
        visibleFilter: _visibleFilter));
  }

  @override
  void setProgrammingLanguage(bool visibleProgrammingLanguage) {
    _filterModel = _filterModel.copyWith(
        visibleProgrammingLanguage: visibleProgrammingLanguage);
    _fetchingDataController.add(HomeModelBloc("concluido",
        isLoading: false,
        user: _user,
        filter: _filterModel,
        visibleFilter: _visibleFilter));
  }

  @override
  void visibleFilter() {
    _visibleFilter = !_visibleFilter;
    _fetchingDataController.add(HomeModelBloc("concluuido",
        isLoading: false,
        user: _user,
        filter: _filterModel,
        visibleFilter: _visibleFilter));
  }

  @override
  void navigatorPop() {
    _navigatorApp.pop();
  }

  @override
  Stream<HomeModelBloc> get onFetchingData => _fetchingDataController.stream;

  @override
  Stream<String> get onUserName => _userNameController.stream;
}
