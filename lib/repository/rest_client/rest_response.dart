import 'dart:typed_data';
import 'package:open_labs/repository/rest_client/helper/list_helper.dart';
import 'irest_response.dart';
import 'rest_client_exception.dart';

class RestResponse implements IRestResponse {
  final int _statusCode;
  final String _content;
  final Uint8List _contentBytes;
  final String _url;

  RestResponse(
      {required int statusCode,
      required String content,
      required Uint8List contentBytes,
      required String url})
      : _statusCode = statusCode,
        _content = content,
        _contentBytes = contentBytes,
        _url = url;

  @override
  String get content => _content;

  @override
  int get statusCode => _statusCode;

  @override
  bool get unauthorized => ListHelper.contains(statusCode, [401, 403]);

  @override
  Uint8List get contentBytes => _contentBytes;

  @override
  String get url => _url;
}

extension ResponseExtension on IRestResponse {
  void ensureSuccess(
      {Function()? customErrorMessage,
      required String restClientExceptionMessage}) {
    if (statusCode == 200) {
      return;
    } else if (unauthorized) {
      throw RestClientException("Sem permissão.", this);
    } else if (statusCode == 404) {
      throw RestClientException("Not found", this);
    } else {
      throw RestClientException("Ocorreu um erro na requisição", this);
    }
  }
}
