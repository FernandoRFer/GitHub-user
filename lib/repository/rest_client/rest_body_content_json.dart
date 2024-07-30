import 'dart:convert';

import 'package:github_user/repository/rest_client/irest_body_content.dart';

class RestBodyContentJson implements IRestBodyContent {
  final Object value;

  RestBodyContentJson.parse(Object json) : value = json;

  @override
  String get contentType => "application/json";

  @override
  render() {
    return json.encode(value);
  }
}
