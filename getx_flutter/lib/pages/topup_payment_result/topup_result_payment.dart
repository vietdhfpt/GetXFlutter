import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_flutter/constants.dart';
import 'package:getx_flutter/pages/home/home_page.dart';
import 'package:getx_flutter/pages/online_payment/online_payment_controller.dart';
import 'package:getx_flutter/pages/widget_share.dart/topup_button_widget.dart';
import 'package:lottie/lottie.dart';

class TopupPaymentResult extends StatelessWidget {
  final OnlinePaymentController _onlinePaymentController = Get.find();

  @override
  Widget build(BuildContext context) {
    final topupCratchCardResp = Get.arguments['topupCratchCardResp'];
    final topupPayMobileResp = Get.arguments['topupPayMobileResp'];
    final cards = topupCratchCardResp != null
        ? topupCratchCardResp.data.products[0].softpins
        : null;
    final phone = Get.arguments['phoneNumber'];
    final amount = Get.arguments['amount'];
    final product = Get.arguments['product'];
    final quantity = Get.arguments['quantity'];
    Size size = MediaQuery.of(context).size;
    final resultMessage = _onlinePaymentController.selectedIndexTopup == 1
        ? 'Quý khách đã nạp $amountđ vào số điện thoại $phone'
        : 'Quý khách đã mua $quantity từ ${product.provider} với mệnh giá ${product.productValue}đ';

    return Scaffold(
      body: Container(
        color: topupBackGroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildHeader(size),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: kPaddingTopup,
                horizontal: kPaddingTopup * 1.5,
              ),
              child: Text(
                resultMessage,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            if (_onlinePaymentController.selectedIndexTopup == 0)
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: kPaddingTopup),
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.vertical,
                    itemCount: cards.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.only(bottom: kPaddingTopup),
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(kBorderRadius),
                        ),
                        child: Container(
                          margin: EdgeInsets.all(kPaddingTopup),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Mã nạp:',
                                    style: TextStyle(
                                      color: Colors.black45,
                                    ),
                                  ),
                                  Text(
                                    '${cards[index].softpinSerial}',
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              Divider(
                                height: 1,
                                color: Colors.black12,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Số seri:',
                                    style: TextStyle(
                                      color: Colors.black45,
                                    ),
                                  ),
                                  Text(
                                    '${cards[index].softpinPinCode}',
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            Container(
              height: 100,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: kPaddingTopup,
                  left: kPaddingTopup,
                  right: kPaddingTopup,
                  bottom: kPaddingTopup * 2,
                ),
                child: Container(
                  child: Row(
                    children: [
                      Expanded(
                        child: TopupButtonWidget(
                          title: 'Màn hình chính',
                          onTap: () {
                            Get.off(() => HomePage());
                          },
                        ),
                      ),
                      SizedBox(width: kPaddingTopup / 2),
                      Container(
                        width: 60,
                        decoration: BoxDecoration(
                          color: appColor,
                          borderRadius: BorderRadius.circular(kBorderRadius),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.share,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _buildHeader(Size size) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(
        top: kPaddingTopup * 2,
        bottom: kPaddingTopup,
      ),
      height: size.height / 4,
      color: appColor,
      child: Container(
        child: Stack(
          children: [
            Center(
              child: Container(
                child: Lottie.asset(
                  'assets/images/success.json',
                  fit: BoxFit.cover,
                  repeat: false,
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Center(
                child: Text(
                  'Giao dịch thành công',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
