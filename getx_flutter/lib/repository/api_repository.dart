import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:getx_flutter/models/topup_register.dart';
import 'package:getx_flutter/services/api_result.dart';
import 'package:getx_flutter/services/dio_client.dart';
import 'package:getx_flutter/services/network_exceptions.dart';

class APIRepository {
  DioClient dioClient;
  String _baseUrl = 'https://api.nssvndev.com';

  String registerPath = '/accounts/register';

  APIRepository() {
    var dio = Dio();
    dioClient = DioClient(_baseUrl, dio);
  }

  Future<ApiResult<TopupRegister>> register(String shopId) async {
    try {
      final parameters = {'shopids': shopId};
      final response =
          await dioClient.post(registerPath, data: jsonEncode(parameters));
      TopupRegister topupRegister = TopupRegister.fromJson(response);
      return ApiResult.success(data: topupRegister);
    } catch (e) {
      return ApiResult.failure(error: NetworkExceptions.getDioException(e));
    }
  }
}
