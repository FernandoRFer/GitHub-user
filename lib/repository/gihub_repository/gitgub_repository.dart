import 'dart:convert';
import 'dart:developer';

import 'package:open_labs/repository/model/logged_user_model.dart';
import 'package:open_labs/repository/model/user_repos_model.dart';
import 'package:open_labs/repository/rest_client/irest_client.dart';
import 'package:open_labs/repository/token_repository/token_respository.dart';
import 'package:open_labs/repository/gihub_repository/igithub_repository.dart';
import 'package:open_labs/repository/model/user_model.dart';

class GithubRepository implements IGithubRepository {
  final IRestClient _restClient;
  final ITokenReposytory _tokenReposytory;

  GithubRepository(
    this._restClient,
    this._tokenReposytory,
  );

  static String url = "https://api.github.com";

  @override
  Future<LoggedUserModel?> getUser(String username) async {
    final authorization = await _tokenReposytory.get();
    var resp = await _restClient.sendGet(
      url: "$url/users/$username",
      authorization: {"Authorization": "Bearer ${authorization?.accessToken}"},
    );

    log(resp.content);
    resp.ensureSuccess(restClientExceptionMessage: "Ocorreu um erro");

    return LoggedUserModel.fromJson(jsonDecode(resp.content));
  }

  @override
  Future<LoggedUserModel?> getLoggedUser() async {
    final authorization = await _tokenReposytory.get();
    var resp = await _restClient.sendGet(
      url: "$url/user",
      authorization: {"Authorization": "Bearer ${authorization?.accessToken}"},
    );

    log(resp.content);
    resp.ensureSuccess(restClientExceptionMessage: "Ocorreu um erro");
    return LoggedUserModel.fromJson(jsonDecode(resp.content));
  }

  @override
  Future<List<UserReposModel?>> repos() async {
    final authorization = await _tokenReposytory.get();
    var resp = await _restClient.sendGet(
      url: "$url/user/repos",
      authorization: authorization != null
          ? {"Authorization": "Bearer ${authorization.accessToken}"}
          : {},
    );

    log("repos - ${resp.content}");
    resp.ensureSuccess(restClientExceptionMessage: "Ocorreu um erro");
    List<dynamic> list = jsonDecode(resp.content);
    return list.map((e) => UserReposModel.fromJson(e)).toList();
  }
}
