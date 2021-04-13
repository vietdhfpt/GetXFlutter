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
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Container(
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
                  Flexible(
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        GetBuilder<OnlinePaymentController>(
                          builder: (_) {
                            return _buildListContent();
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            _calculatorPaymentWidget()
          ],
        ),
      ),
    );
  }

  Widget _buildListContent() {
    switch (_controller.selectedIndexTopup) {
      case 0:
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
      case 1:
        return Container(
          height: 900,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: kPaddingTopup,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _advancePaySection(),
                SizedBox(height: kSpacing),
                _inputPhoneNumberSection(),
                SizedBox(height: kSpacing),
                TopupProviderWidget(),
                SizedBox(height: kSpacing),
                TopupProductWidget(),
                SizedBox(height: kSpacing),
              ],
            ),
          ),
        );
      default:
        return Container(
          height: 800,
          color: topupBackGroundColor,
          child: Container(),
        );
    }
  }

  Widget _advancePaySection() {
    return Container(
      width: Get.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(kBorderRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.all(kPaddingTopup),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Nhà mạng',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(height: kPaddingTopup),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildAdvancePayItem(
                  title: 'Trả trước',
                  value: 0,
                  onSelected: () {
                    _controller.setAccountType(0);
                  },
                ),
                SizedBox(width: kPaddingTopup * 2),
                _buildAdvancePayItem(
                  title: 'Trả sau',
                  value: 1,
                  onSelected: () {
                    _controller.setAccountType(1);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAdvancePayItem({
    @required String title,
    @required int value,
    Function onSelected,
  }) {
    return GestureDetector(
      onTap: onSelected,
      child: Container(
        height: 30,
        child: Row(
          children: [
            Row(
              children: [
                Icon(
                  _controller.accountType == value
                      ? Icons.radio_button_on
                      : Icons.radio_button_off,
                  color:
                      _controller.accountType == value ? appColor : Colors.grey,
                ),
                SizedBox(width: 5),
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _inputPhoneNumberSection() {
    return Container(
      width: Get.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(kBorderRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.all(kPaddingTopup),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Số điện thoại',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(height: kPaddingTopup),
            Container(
              height: 45,
              child: TextFormField(
                controller: _controller.phoneNumberController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: new OutlineInputBorder(
                    borderSide: new BorderSide(color: appColor),
                  ),
                  hintText: 'Nhập số điện thoại',
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 0,
                    horizontal: kPaddingTopup,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Positioned _calculatorPaymentWidget() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Obx(() {
        return Container(
          height: _controller.isInputQuantity ? 170 : 118,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(
              top: kPaddingTopup / 2,
              left: kPaddingTopup,
              right: kPaddingTopup,
              bottom: kPaddingTopup * 2,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (_controller.isInputQuantity)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Số lượng:'),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              _controller.processCalculateMoney(
                                  isIncrement: false);
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
                              borderRadius:
                                  BorderRadius.circular(kBorderRadius),
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
                              _controller.processCalculateMoney(
                                  isIncrement: true);
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
                if (_controller.isInputQuantity)
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
        );
      }),
    );
  }
}
