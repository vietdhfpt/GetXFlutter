import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:getx_flutter/models/topup_base.dart';
import 'package:dio/dio.dart';
import 'package:getx_flutter/services/bloc_response.dart';

const TOPUP_BASE_URL = 'https://api.nssvndev.com';
const String token =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InhfVTNjTUNFUW8iLCJzaG9waWQiOiJmZmYxNmJkZi0zOGJhLTQyNTMtYWY5OC1lZWYyZDliZjY2NzkiLCJpc01lcmNoYW50Ijp0cnVlLCJpYXQiOjE2MTcxNzg2MjR9.ExOVIiiwbjJgSjVv_4JpuLECst-IO-CHT4bYLFb3oeo';

class BaseNetwork {
  static Future<BlocResponse> get(String partUrl) async {
    Dio _dio = Dio();
    _dio.options.baseUrl = TOPUP_BASE_URL;
    _dio.options.headers['Content-Type'] = 'application/json';
    _dio.options.connectTimeout = 20000;
    _dio.options.receiveTimeout = 20000;
    if (kDebugMode) {
      _dio.interceptors.add(LogInterceptor(
        responseBody: true,
        error: true,
        requestHeader: false,
        responseHeader: false,
        request: false,
        requestBody: true,
      ));
    }

    // GetStorage tokenStorage = GetStorage();
    // String token = tokenStorage.read('TOPUP_TOKEN');
    String token =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InhfVTNjTUNFUW8iLCJzaG9waWQiOiJmZmYxNmJkZi0zOGJhLTQyNTMtYWY5OC1lZWYyZDliZjY2NzkiLCJpc01lcmNoYW50Ijp0cnVlLCJpYXQiOjE2MTcxNzg2MjR9.ExOVIiiwbjJgSjVv_4JpuLECst-IO-CHT4bYLFb3oeo';
    _dio.options.headers["Authorization"] = "Bearer $token";

    try {
      Response response = await _dio.get(partUrl);
      return _processResponse(response);
    } on DioError catch (dioError) {
      return _handleError(dioError);
    } catch (e) {
      return BlocResponse.error(e);
    }
  }

  static Future<BlocResponse> post({
    String partUrl,
    dynamic parameters,
    bool isRegister = false,
  }) async {
    Dio _dio = Dio();
    _dio.options.baseUrl = TOPUP_BASE_URL;
    _dio.options.headers['Content-Type'] = 'application/json';
    _dio.options.connectTimeout = 20000;
    _dio.options.receiveTimeout = 20000;
    if (kDebugMode) {
      _dio.interceptors.add(LogInterceptor(
          responseBody: true,
          error: true,
          requestHeader: false,
          responseHeader: false,
          request: false,
          requestBody: true));
    }
    if (!isRegister) {
      // GetStorage tokenStorage = GetStorage();
      // String token = tokenStorage.read('TOPUP_TOKEN');
      String token =
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InhfVTNjTUNFUW8iLCJzaG9waWQiOiJmZmYxNmJkZi0zOGJhLTQyNTMtYWY5OC1lZWYyZDliZjY2NzkiLCJpc01lcmNoYW50Ijp0cnVlLCJpYXQiOjE2MTcxNzg2MjR9.ExOVIiiwbjJgSjVv_4JpuLECst-IO-CHT4bYLFb3oeo';
      _dio.options.headers["Authorization"] = "Bearer $token";
    }

    try {
      Response response =
          await _dio.post(partUrl, data: jsonEncode(parameters));
      return _processResponse(response);
    } on DioError catch (dioError) {
      return _handleError(dioError);
    } catch (e) {
      return BlocResponse.error(e);
    }
  }

  static Future<BlocResponse> _processResponse(
    Response response,
  ) async {
    final data = response.data ?? "";
    var baseResponse = TopupBase.fromJson(response.data);
    if (baseResponse.error) {
      return BlocResponse.error(baseResponse.message);
    }

    if (response.statusCode == 200) {
      if (data.isNotEmpty) {
        return BlocResponse.completed(data);
      } else {
        return BlocResponse.error('Response data from server is empty');
      }
    } else {
      return BlocResponse.error('Unknown error request server');
    }
  }

  static BlocResponse _handleError(DioError dioError) {
    if (dioError.type == DioErrorType.CONNECT_TIMEOUT ||
        dioError.type == DioErrorType.RECEIVE_TIMEOUT) {
      return BlocResponse.error('Request timeout');
    } else if (dioError.type == DioErrorType.RESPONSE) {
      if (dioError.response != null) {
        if (dioError.response.data is Map<String, dynamic>) {
          var baseResponse = TopupBase.fromJson(dioError.response.data);
          if (baseResponse.error) {
            return BlocResponse.error(baseResponse.message);
          }
        }
        return BlocResponse.error(dioError.response.statusMessage);
      }
      return BlocResponse.error(dioError.message);
    } else {
      return BlocResponse.error(
        'Problem connecting to the server. Please try again.',
      );
    }
  }
}
