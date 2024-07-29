import 'dart:convert';

import 'package:open_labs/repository/local_storage/storage_cache.dart';
import 'package:open_labs/repository/model/token_model.dart';
import 'package:open_labs/repository/rest_client/irest_client.dart';

abstract class ClienData {
  static String clientId = const String.fromEnvironment('CLIENT_ID');
  static String clientSecret = const String.fromEnvironment('CLIENT_SECRET');
}

abstract class ITokenReposytory {
  Future<void> create(String authentication);
  Future<TokenModel?> get();
}

class TokenReposytory implements ITokenReposytory {
  final IRestClient _restClient;
  final IStorageCache _storageCache;

  TokenReposytory(
    this._restClient,
    this._storageCache,
  );

  final _nameFilelToken = "Token";

  @override
  Future<void> create(String authentication) async {
    var uri = Uri.parse("https://github.com/login/oauth/access_token")
        .resolveUri(Uri(queryParameters: {
      "code": authentication,
      "client_id": ClienData.clientId,
      "client_secret": ClienData.clientSecret,
      "redirect_uri": "https://fernandorfer.github.io",
    }));

    var resp = await _restClient.sendPost(
        url: uri.toString(), headers: {"Accept": "application/json"}, body: {});

    resp.ensureSuccess(
        restClientExceptionMessage: "Ocorreu um erro ao gerar o token");

    await _storageCache.put(_nameFilelToken, resp.content);
  }

  @override
  Future<TokenModel?> get() async {
    final data = await _storageCache.get(_nameFilelToken);

    if (data == null) return null;

    return TokenModel.fromJson(jsonDecode(data));
  }
}
