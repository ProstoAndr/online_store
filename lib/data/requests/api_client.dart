import 'dart:io';

import 'package:dio/dio.dart';
import 'package:online_store/untils/logger.dart';

class ApiClient {
  final String _baseUrl;

  ApiClient(this._baseUrl);

  late final _dio =  Dio(
    BaseOptions(
      baseUrl: _baseUrl,
      headers: {
        Headers.contentTypeHeader: ContentType.json.value,
        Headers.acceptHeader: ContentType.json.value,
      },
      connectTimeout: const Duration(seconds: 3),
      receiveTimeout: const Duration(seconds: 5),
      validateStatus: (status) {
        return status != null && ((status >= 200 && status < 300) || status == 500 || status == 401 || status == 403);
      },
    ),
  )..interceptors.addAll([
    InterceptorsWrapper(
      onRequest: (request, handler) {
        Logger.I(
          "Executing request ${request.method}: ${request.uri.toString()}${request.data == null ? '' : ' with data: ${request.data}'}",
        );
        handler.next(request);
      },
      onResponse: (response, handler) {
        if (response.statusCode == 401) {
          Logger.I("Unauthorized for request ${response.requestOptions.method}: ${response.realUri.data}");
        } else {
          Logger.I(
            "Response for request ${response.requestOptions.method}: ${response.requestOptions.uri.toString()}: ${response.data}",
          );
        }
        handler.next(response);
      },
    ),
  ]);

  Future<Response<Map<String, dynamic>>> get({required String path}) {
    return _dio.get<Map<String, dynamic>>(path);
  }

  Future<Response<Map<String, dynamic>>> post({
    required String path,
    Map<String, dynamic>? data,
  }) {
    return _dio.post<Map<String, dynamic>>(path, data: data);
  }

  Future<Response<Map<String, dynamic>>> delete({
    required String path,
    Map<String, dynamic>? data,
  }) {
    return _dio.delete(path, data: data);
  }
}