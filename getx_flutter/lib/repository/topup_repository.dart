import 'package:flutter/material.dart';
import 'package:getx_flutter/models/topup_history.dart';
import 'package:getx_flutter/models/topup_product.dart';
import 'package:getx_flutter/models/topup_balance.dart';
import 'package:getx_flutter/models/topup_cratch_card_resp.dart';
import 'package:getx_flutter/models/topup_register.dart';
import 'package:getx_flutter/repository/base_network.dart';
import 'package:getx_flutter/services/bloc_response.dart';
import 'package:getx_flutter/sp_snackar.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class TopupRepository {
  static TopupRepository instance = TopupRepository();
  static var client = http.Client();

  Future<TopupRegister> register({@required String shopId}) async {
    final parameters = {
      'shopid': shopId,
    };

    BlocResponse response = await BaseNetwork.post(
      partUrl: '/accounts/register',
      parameters: parameters,
      isRegister: true,
    );

    switch (response.status) {
      case BlocResponseStatus.COMPLETED:
        return TopupRegister.fromJson(response.data);
      default:
        SPSnackbar.instance.show(message: response.message);
        return null;
    }
  }

  Future<TopupProduct> getProducts() async {
    BlocResponse response = await BaseNetwork.get('/products');

    switch (response.status) {
      case BlocResponseStatus.COMPLETED:
        return TopupProduct.fromJson(response.data);
      default:
        SPSnackbar.instance.show(message: response.message);
        return null;
    }
  }

  Future<TopupBalance> getBalance() async {
    BlocResponse response = await BaseNetwork.get('/topup/queryBalance');

    switch (response.status) {
      case BlocResponseStatus.COMPLETED:
        return TopupBalance.fromJson(response.data);
      default:
        SPSnackbar.instance.show(message: response.message);
        return null;
    }
  }

  Future<TopupHistoryResp> getHistories(int from, int to) async {
    BlocResponse response =
        await BaseNetwork.get('/topup/transactions?from=$from&to=$to');
    switch (response.status) {
      case BlocResponseStatus.COMPLETED:
        return TopupHistoryResp.fromJson(response.data);
      default:
        SPSnackbar.instance.show(message: response.message);
        return null;
    }
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

    BlocResponse response = await BaseNetwork.post(
      partUrl: '/topup/download',
      parameters: parameters,
    );

    switch (response.status) {
      case BlocResponseStatus.COMPLETED:
        return TopupCratchCardResp.fromJson(response.data);
      default:
        SPSnackbar.instance.show(message: response.message);
        return null;
    }
  }
}
