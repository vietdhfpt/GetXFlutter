import 'package:flutter/material.dart';
import 'package:getx_flutter/models/topup_product.dart';
import 'package:getx_flutter/models/topup_balance.dart';
import 'package:getx_flutter/models/topup_cratch_card_resp.dart';
import 'package:getx_flutter/models/topup_register.dart';
import 'package:getx_flutter/repository/base_network.dart';
import 'package:getx_flutter/sp_snackar.dart';
import 'package:http/http.dart' as http;

class TopupRepository {
  static TopupRepository instance = TopupRepository();
  static var client = http.Client();

  Future<TopupRegister> register({@required String shopId}) async {
    final parameters = {
      'shopid': shopId,
    };

    return await BaseNetwork.post(
      partUrl: '/accounts/register',
      parameters: parameters,
      isRegister: true,
    ).then((response) {
      return TopupRegister.fromJson(response);
    }).catchError((error) {
      SPSnackbar.instance.show(message: error);
    });
  }

  Future<TopupProduct> getProducts() async {
    return await BaseNetwork.get('/products').then((response) {
      return TopupProduct.fromJson(response);
    }).catchError((error) {
      SPSnackbar.instance.show(message: error);
    });
  }

  Future<TopupBalance> getBalance() async {
    return await BaseNetwork.get('/topup/queryBalance').then((response) {
      return TopupBalance.fromJson(response);
    }).catchError((error) {
      SPSnackbar.instance.show(message: error);
    });
  }

  Future<TopupCratchCardResp> paymentCratchCard({
    @required int productId,
    @required int quantity,
  }) async {
    final parameters = [
      {
        'productId': productId,
        'quantity': quantity,
      },
    ];

    return await BaseNetwork.post(
      partUrl: '/topup/download',
      parameters: parameters,
    ).then((response) {
      return TopupCratchCardResp.fromJson(response);
    }).catchError((error) {
      SPSnackbar.instance.show(message: error);
    });
  }
}
