import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:github_user/repository/rest_client/irest_client.dart';
import 'package:github_user/repository/rest_client/irest_response.dart';
import 'package:github_user/repository/rest_client/rest_response.dart';

class RestClient implements IRestClient {
  final int secondsTimeout = 20;

  @override
  Future<IRestResponse> sendGet(
      {required String url,
      Map<String, String>? headers,
      Map<String, String>? authorization}) async {
    http.Request request = http.Request('GET', Uri.parse(url));

    request.headers.addAll(authorization ?? {});
    request.headers.addAll(headers ?? {});

    http.StreamedResponse response =
        await request.send().timeout(Duration(seconds: secondsTimeout));

    Uint8List bytes = await response.stream.toBytes();

    return RestResponse(
        url: url,
        statusCode: response.statusCode,
        content: utf8.decode(bytes),
        contentBytes: bytes);
  }

  @override
  Future<IRestResponse> sendDelete(
      {required String url,
      Map<String, String>? headers,
      Map<String, String>? authorization}) async {
    http.Request request = http.Request('DELET', Uri.parse(url));

    request.headers.addAll(authorization ?? {});
    request.headers.addAll(headers ?? {});

    http.StreamedResponse response =
        await request.send().timeout(Duration(seconds: secondsTimeout));

    Uint8List bytes = await response.stream.toBytes();

    return RestResponse(
        url: url,
        statusCode: response.statusCode,
        content: utf8.decode(bytes),
        contentBytes: bytes);
  }

  @override
  Future<IRestResponse> sendPost({
    required String url,
    required Map<String, dynamic>? body,
    Map<String, String>? headers,
    Map<String, String>? authorization,
  }) async {
    http.Request request = http.Request('POST', Uri.parse(url));

    request.body = json.encode(body);

    request.headers.addAll(authorization ?? {});
    request.headers.addAll(headers ?? {});

    http.StreamedResponse response =
        await request.send().timeout(Duration(seconds: secondsTimeout));

    Uint8List bytes = await response.stream.toBytes();

    return RestResponse(
        url: url,
        statusCode: response.statusCode,
        content: utf8.decode(bytes),
        contentBytes: bytes);
  }

  @override
  Future<IRestResponse> sendPut({
    required String url,
    required Map<String, dynamic>? body,
    Map<String, String>? headers,
    Map<String, String>? authorization,
  }) async {
    var request = http.Request('PUT', Uri.parse(url));

    request.body = json.encode(body);

    request.headers.addAll(authorization ?? {});
    request.headers.addAll(headers ?? {});

    var response =
        await request.send().timeout(Duration(seconds: secondsTimeout));

    Uint8List bytes = await response.stream.toBytes();

    return RestResponse(
        url: url,
        statusCode: response.statusCode,
        content: utf8.decode([]),
        contentBytes: bytes);
  }
}
