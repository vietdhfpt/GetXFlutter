import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_flutter/constants.dart';
import 'package:getx_flutter/pages/online_payment/online_payment_controller.dart';

class TopupBalanceWidget extends GetView<OnlinePaymentController> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: kPaddingTopup,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: kPaddingTopup,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kBorderRadius),
          color: appColor,
        ),
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Số dư tài khoản:',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            Obx(() {
              return Text(
                '${controller.balance} đ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}