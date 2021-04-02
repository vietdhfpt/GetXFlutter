import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_flutter/constants.dart';
import 'package:getx_flutter/pages/online_payment/online_payment_controller.dart';
import 'package:getx_flutter/pages/online_payment/widgets/topup_balance_widget.dart';
import 'package:getx_flutter/pages/online_payment/widgets/topup_product_widget.dart';
import 'package:getx_flutter/pages/online_payment/widgets/topup_provider_widget.dart';
import 'package:getx_flutter/pages/online_payment/widgets/topup_widget.dart';
import 'package:getx_flutter/pages/widget_share.dart/topup_button_widget.dart';

class OnlinePaymentPage extends StatelessWidget {
  final OnlinePaymentController _controller =
      Get.put(OnlinePaymentController());

  @override
  Widget build(BuildContext context) {
    return Container(
      color: topupBackGroundColor,
      child: Stack(
        children: [
          Container(
            child: Column(
              children: [
                SizedBox(height: kSpacing),
                TopupBalanceWidget(),
                SizedBox(height: kSpacing),
                TopupWidget(),
                SizedBox(height: kSpacing),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 700,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: kPaddingTopup,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              TopupProviderWidget(),
                              SizedBox(height: kSpacing),
                              TopupProductWidget(),
                              SizedBox(height: kSpacing),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          _calculatorPaymentWidget()
        ],
      ),
    );
  }

  Positioned _calculatorPaymentWidget() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        height: 170,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(
              top: kPaddingTopup / 2,
              left: kPaddingTopup,
              right: kPaddingTopup,
              bottom: kPaddingTopup * 2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Số lượng:'),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          _controller.processCalculateMoney(isIncrement: false);
                        },
                        child: Icon(
                          Icons.remove_circle,
                          size: 35,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(width: 5),
                      Container(
                        height: 30,
                        width: 40,
                        decoration: BoxDecoration(
                          color: appColor,
                          borderRadius: BorderRadius.circular(kBorderRadius),
                        ),
                        child: Center(
                          child: Obx(() {
                            return Text(
                              '${_controller.quantity}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            );
                          }),
                        ),
                      ),
                      SizedBox(width: 5),
                      GestureDetector(
                        onTap: () {
                          _controller.processCalculateMoney(isIncrement: true);
                        },
                        child: Icon(
                          Icons.add_circle,
                          size: 35,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Divider(
                height: 2,
                color: Colors.black38,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Tổng tiền:'),
                  Obx(() {
                    return Text(
                      '${_controller.amount} đ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    );
                  }),
                ],
              ),
              TopupButtonWidget(
                title: 'Thanh toán',
                onTap: () {
                  _controller.payment();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
