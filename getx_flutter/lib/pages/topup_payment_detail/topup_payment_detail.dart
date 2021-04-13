import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_flutter/constants.dart';
import 'package:getx_flutter/models/topup_product.dart';
import 'package:getx_flutter/pages/online_payment/online_payment_controller.dart';
import 'package:getx_flutter/pages/topup_payment_detail/topup_payment_detail_controller.dart';
import 'package:getx_flutter/pages/widget_share.dart/topup_button_widget.dart';

class TopupPaymentDetail extends StatelessWidget {
  final TopupPaymentDetailController _controller =
      Get.put(TopupPaymentDetailController());
  final OnlinePaymentController _onlinePaymentController = Get.find();

  @override
  Widget build(BuildContext context) {
    final product = Get.arguments['product'] as Item;
    final quantity = Get.arguments['quantity'] as int;
    final totalAmount = Get.arguments['amount'] as int;
    final accountType = Get.arguments['accountType'] as int;
    final phoneNumber = Get.arguments['phoneNumber'] as String;

    return Scaffold(
      appBar: AppBar(
        title: Text('Chi tiết giao dịch'),
      ),
      body: Stack(
        children: [
          Container(
            color: topupBackGroundColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(kPaddingTopup),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(kPaddingTopup),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(kBorderRadius),
                    ),
                    child: Column(
                      children: [
                        buildInfo(
                          title: 'Nhà mạng: ',
                          value: '${product.provider}',
                        ),
                        SizedBox(height: kSpacing),
                        if (_onlinePaymentController.selectedIndexTopup == 1)
                          _buildInfoMobilePay(phoneNumber, accountType),
                        SizedBox(height: kSpacing),
                        buildInfo(
                          title: 'Hoàn lại: ',
                          value:
                              '${product.productValue - product.finalPrice} đ',
                        ),
                        SizedBox(height: kSpacing),
                        if (_onlinePaymentController.isInputQuantity)
                          buildInfo(
                            title: 'Số lượng: ',
                            value: '$quantity',
                          ),
                        SizedBox(
                          height: _onlinePaymentController.isInputQuantity
                              ? kSpacing * 2
                              : 0,
                        ),
                        Divider(height: 1, color: Colors.black38),
                        SizedBox(height: kSpacing),
                        buildInfo(
                          title: 'Phí giao dịch: ',
                          value: 'Miễn phí',
                        ),
                        SizedBox(height: kSpacing),
                        Divider(height: 1, color: Colors.black38),
                        SizedBox(height: kSpacing),
                        buildInfo(
                          title: 'Tổng tiền: ',
                          value: '$totalAmount đ',
                        ),
                      ],
                    ),
                  ),
                ),
                buildPaymentButton(
                  product: product,
                  quantity: quantity,
                  phone: phoneNumber,
                  provider: product.provider,
                  amount: product.productValue,
                  accountType: '$accountType',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoMobilePay(String phone, int accountType) {
    String result = accountType == 0 ? 'Trả trước' : 'Trả sau';
    return Column(
      children: [
        buildInfo(
          title: 'Hình thức: ',
          value: result,
        ),
        SizedBox(height: kSpacing),
        buildInfo(
          title: 'Số điện thoại: ',
          value: phone,
        ),
      ],
    );
  }

  Widget buildPaymentButton({
    @required dynamic product,
    @required int quantity,
    @required String phone,
    @required String provider,
    @required int amount,
    @required String accountType,
  }) {
    return Container(
      height: 100,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(
          top: kPaddingTopup,
          left: kPaddingTopup,
          right: kPaddingTopup,
          bottom: kPaddingTopup * 2,
        ),
        child: Obx(() {
          if (_controller.isLoading) {
            return Container(
              height: 50,
              decoration: BoxDecoration(
                color: appColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Container(
                  width: 24,
                  height: 24,
                  child: CupertinoActivityIndicator(),
                ),
              ),
            );
          } else {
            return TopupButtonWidget(
              title: 'Xác nhận',
              onTap: () {
                if (_onlinePaymentController.selectedIndexTopup == 0)
                  _controller.cratchCardPayment(
                    product: product,
                    quantity: quantity,
                  );
                else
                  _controller.mobilePayment(
                    phone: phone,
                    provider: provider,
                    amount: amount,
                    accountType: accountType,
                  );
              },
            );
          }
        }),
      ),
    );
  }

  Widget buildInfo({@required String title, @required String value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.black54,
            fontSize: 16,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}
