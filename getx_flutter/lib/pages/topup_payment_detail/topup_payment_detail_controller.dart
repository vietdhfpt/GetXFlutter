import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_flutter/pages/online_payment/online_payment_controller.dart';
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
    @required int productId,
    @required int quantity,
  }) async {
    try {
      _isLoading.value = true;
      final topupCratchCardResp = await TopupRepository.instance
          .paymentCratchCard(productId: productId, quantity: quantity);
      if (topupCratchCardResp != null) {
        OnlinePaymentController paymentController = Get.find();
        paymentController.reloadBalance(topupCratchCardResp.data.merchantBalance);
        print('-------- $topupCratchCardResp');
      } else {
        SPSnackbar.instance.show(message: 'TopupCratchCardResp is null');
      }
    } finally {
      _isLoading.value = false;
    }
  }
}
