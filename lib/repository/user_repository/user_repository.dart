import 'dart:convert';
import 'dart:developer';

import 'package:open_labs/repository/user_repository/model/user_model.dart';

import '../rest_client/rest_response.dart';
import '../rest_client/irest_client.dart';
import 'iuser_repository.dart';

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
    resp.ensureSuccess(restClientExceptionMessage: "Ocorreu um erro");

    log(resp.content);

    return UserModel.fromJson(jsonDecode(resp.content));
  }
}
