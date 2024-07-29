import 'irest_response.dart';

abstract class IRestClient {
  Future<IRestResponse> sendGet(
      {required String url,
      Map<String, String>? headers,
      Map<String, String>? authorization});

  Future<IRestResponse> sendPost({
    required String url,
    required Map<String, dynamic>? body,
    Map<String, String>? headers,
    Map<String, String>? authorization,
  });

  Future<IRestResponse> sendDelete(
      {required String url,
      Map<String, String>? headers,
      Map<String, String>? authorization});

  Future<IRestResponse> sendPut({
    required String url,
    required Map<String, dynamic>? body,
    Map<String, String>? headers,
    Map<String, String>? authorization,
  });
}
