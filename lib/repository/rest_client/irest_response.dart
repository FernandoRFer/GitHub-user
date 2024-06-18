import 'dart:typed_data';

abstract class IRestResponse {
  int get statusCode;
  String get url;
  String get content;
  Uint8List get contentBytes;
  bool get unauthorized;
}
