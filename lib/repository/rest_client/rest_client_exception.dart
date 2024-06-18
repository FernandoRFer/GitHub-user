import 'dart:convert';

import 'package:open_labs/repository/rest_client/model/rest_error.dart';

import 'irest_response.dart';

class RestClientException implements Exception {
  final IRestResponse response;
  final String message;
  RestClientException(this.message, this.response);

  @override
  String toString() {
    String getMsg = getMessage();
    return "message=[$getMsg]\nurl=${response.url}\nstatuscode=[${response.statusCode}]\ncontent=[${response.content}]";
  }

  bool get isRestError =>
      response.statusCode == 400 &&
      RegExp('("message"|"octicon")').hasMatch(response.content);

  List<RestError> getErrors() {
    if (isRestError) {
      List<dynamic> data = jsonDecode(response.content);
      return data.map((json) => RestError.fromJson(json)).toList();
    } else {
      throw Exception("Não é RestError");
    }
  }

  String getMessage() {
    String ret = "Ocorreu um erro na requisição";
    if (isRestError) {
      List<RestError> list = getErrors();
      ret = list.map((e) => e.message).join("\n");
    } else {
      ret = message;
    }
    return ret;
  }
}
