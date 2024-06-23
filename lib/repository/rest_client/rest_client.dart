import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:open_labs/repository/rest_client/helper/map_helper.dart';
import 'package:open_labs/repository/rest_client/irest_body_content.dart';
import 'package:open_labs/repository/rest_client/irest_client.dart';
import 'package:open_labs/repository/rest_client/irest_response.dart';
import 'package:open_labs/repository/rest_client/rest_response.dart';

class RestClient implements IRestClient {
  final int secondsTimeout = 20;

  @override
  Future<IRestResponse> sendDelete(
      {required String url,
      Map<String, String>? headers,
      String? authorization}) async {
    http.Request request = http.Request('DELET', Uri.parse(url));

    request.headers.addAll(MapHelper.mergeMaps([
      authorization != null ? {"Authorization": authorization} : null,
      headers
    ]));

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
  Future<IRestResponse> sendGet(
      {required String url,
      Map<String, String>? headers,
      String? authorization}) async {
    http.Request request = http.Request('GET', Uri.parse(url));

    request.headers.addAll(MapHelper.mergeMaps([
      authorization != null ? {"Authorization": authorization} : null,
      headers
    ]));

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
    required IRestBodyContent body,
    Map<String, String>? headers,
    String? authorization,
  }) async {
    http.Request request = http.Request('POST', Uri.parse(url));

    request.body = body.render();
    request.headers.addAll(MapHelper.mergeMaps([
      {"Content-Type": body.contentType},
      authorization != null ? {"Authorization": authorization} : null,
      headers
    ]));

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
    required IRestBodyContent body,
    Map<String, String>? headers,
    String? authorization,
  }) async {
    var request = http.Request('PUT', Uri.parse(url));
    request.body = jsonEncode(body);
    request.headers.addAll(MapHelper.mergeMaps([
      {"Content-Type": body.contentType},
      authorization != null ? {"Authorization": authorization} : null,
      headers
    ]));

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



//exemplo http.client 
    // Response response = await _client
    //     .get(Uri.parse(url),
    //         headers: MapHelper.mergeMaps([
    //           authorization != null ? {"Authorization": authorization} : null,
    //           headers
    //         ]))
    //     .timeout(Duration(seconds: secondsTimeout));
