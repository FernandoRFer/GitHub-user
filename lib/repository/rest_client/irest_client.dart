import 'package:open_labs/repository/rest_client/irest_body_content.dart';

import 'irest_response.dart';

abstract class IRestClient {
  Future<IRestResponse> sendGet(
      {required String url,
      Map<String, String>? headers,
      String? authorization});
  Future<IRestResponse> sendDelete(
      {required String url,
      Map<String, String>? headers,
      String? authorization});
  Future<IRestResponse> sendPost({
    required String url,
    required IRestBodyContent body,
    Map<String, String>? headers,
    String? authorization,
  });
  Future<IRestResponse> sendPut({
    required String url,
    required IRestBodyContent body,
    Map<String, String>? headers,
    String? authorization,
  });
}
