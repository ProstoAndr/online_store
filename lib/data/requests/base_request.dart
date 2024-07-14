import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:online_store/data/requests/api_client.dart';
import 'package:online_store/untils/logger.dart';


enum RequestMethod {
  get,
  post,
  delete,
}

abstract class BaseRequest<T> {
  final Map<String, dynamic>? data;
  final String method;
  final RequestMethod requestMethod;

  BaseRequest(
      this.method, {
        this.data,
        RequestMethod? requestMethod,
      }) : requestMethod = requestMethod ?? (data == null ? RequestMethod.get : RequestMethod.post);

  Future<ApiResult<T>> execute(ApiClient client) async {
    try {
      var response = await _executeInner(client);
      return _processInner(response);
    } catch (err) {
      Logger.E("Error while executing request $requestMethod: $method: $err");
      return ApiResultNoInternet();
    }
  }

  Future<Response<Map<String, dynamic>>> _executeInner(ApiClient client) {
    switch (requestMethod) {
      case RequestMethod.get:
        return client.get(path: method);
      case RequestMethod.post:
        return client.post(path: method, data: data);
      case RequestMethod.delete:
        return client.delete(path: method, data: data);
    }
  }

  Future<ApiResult<T>> _processInner(
      Response<Map<String, dynamic>> response,
      ) async {
    try {
      if (response.statusCode != 200) {
        return ApiResultFailure(
          response.data?["errorCode"] as int? ?? -1,
          response.data?["message"] as String?,
        );
      }

      return ApiResultSuccess(await processResponse(response.data ?? {}));
    } catch (err, stackTrace) {
      debugPrint("Error while processing response: $err");
      debugPrintStack(stackTrace: stackTrace);
      return ApiResultFailure(-1);
    }
  }

  FutureOr<T> processResponse(Map<String, dynamic> data);
}

sealed class ApiResult<T> {}

class ApiResultSuccess<T> implements ApiResult<T> {
  final T data;

  ApiResultSuccess(this.data);
}

class ApiResultFailure<T> implements ApiResult<T> {
  final int errorCode;
  final String? message;

  ApiResultFailure(this.errorCode, [this.message]);
}

class ApiResultNoInternet<T> implements ApiResult<T> {}