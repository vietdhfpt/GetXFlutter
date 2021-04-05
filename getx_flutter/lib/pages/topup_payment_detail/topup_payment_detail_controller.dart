import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_flutter/pages/online_payment/online_payment_controller.dart';
import 'package:getx_flutter/pages/topup_payment_result/topup_result_payment.dart';
import 'package:getx_flutter/repository/topup_repository.dart';
import 'package:getx_flutter/sp_snackar.dart';

class TopupPaymentDetailController extends GetxController {
  var _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  @override
  void onInit() {
    super.onInit();
  }

  void cratchCardPayment({
    @required dynamic product,
    @required int quantity,
  }) async {
    try {
      _isLoading.value = true;
      final topupCratchCardResp = await TopupRepository.instance
          .paymentCratchCard(productId: product.id, quantity: quantity);
      if (topupCratchCardResp != null) {
        OnlinePaymentController paymentController = Get.find();
        paymentController
            .reloadBalance(topupCratchCardResp.data.merchantBalance);
        _showTopupResult(topupCratchCardResp, product, quantity);
      } else {
        SPSnackbar.instance.show(message: 'TopupCratchCardResp is null');
      }
    } finally {
      _isLoading.value = false;
    }
  }

  void _showTopupResult(
      dynamic topupCratchCardResp, dynamic respProduct, dynamic quantity) {
    var arguments = <String, dynamic>{
      'product': respProduct,
      'topupCratchCardResp': topupCratchCardResp,
      'quantity': quantity,
    };
    Get.to(TopupPaymentResult(), arguments: arguments);
  }
}
