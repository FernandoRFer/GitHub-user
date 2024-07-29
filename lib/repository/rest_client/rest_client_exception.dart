import 'irest_response.dart';

class RestClientException implements Exception {
  final IRestResponse response;
  final String message;
  RestClientException(this.message, this.response);

  @override
  String toString() {
    return "message=[$message]\nurl=${response.url}\nstatuscode=[${response.statusCode}]\ncontent=[${response.content}]";
  }
}
