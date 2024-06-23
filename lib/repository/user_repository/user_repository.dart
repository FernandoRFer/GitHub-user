import 'dart:convert';
import 'dart:developer';

import 'package:open_labs/repository/rest_client/irest_client.dart';
import 'package:open_labs/repository/user_repository/iuser_repository.dart';
import 'package:open_labs/repository/user_repository/model/user_model.dart';

class UserRepository implements IUserRepository {
  final IRestClient _restClient;

  UserRepository(
    this._restClient,
  );

  static String url = "https://api.github.com";

  @override
  Future<UserModel?> getUsers(String username) async {
    var resp = await _restClient.sendGet(
      url: "$url/users/$username",
    );

    log(resp.content);
    resp.ensureSuccess(restClientExceptionMessage: "Ocorreu um erro");

    return UserModel.fromJson(jsonDecode(resp.content));
  }
}
