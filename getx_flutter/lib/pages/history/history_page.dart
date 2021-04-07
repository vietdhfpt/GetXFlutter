import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_flutter/constants.dart';
import 'package:getx_flutter/models/topup_history.dart';
import 'package:getx_flutter/pages/history/history_controller.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: topupBackGroundColor,
        child: GetX<HistoryController>(
          init: HistoryController(),
          builder: (controller) {
            if (controller.isLoading) {
              return Center(
                child: SizedBox(
                  child: CupertinoActivityIndicator(),
                  height: 70,
                  width: 70,
                ),
              );
            }

            return Column(
              children: [
                Container(
                  margin: EdgeInsets.all(kPaddingTopup),
                  child: Row(
                    children: [
                      _buildDateForm(
                        title: controller
                            .convertTimeStampToStringDate(controller.fromDate),
                        onTap: () {
                          _buildPickerDatetime(
                            context: context,
                            controller: controller,
                            isFromDate: true,
                          );
                        },
                      ),
                      SizedBox(width: kPaddingTopup),
                      _buildDateForm(
                        title: controller
                            .convertTimeStampToStringDate(controller.toDate),
                        onTap: () {
                          _buildPickerDatetime(
                            context: context,
                            controller: controller,
                            isFromDate: false,
                          );
                        },
                      ),
                    ],
                  ),
                ),
                controller.isNodataAvailable
                    ? _buildNodataWidget()
                    : _buildHistories(controller),
              ],
            );
          },
        ),
      ),
    );
  }

  Expanded _buildHistories(HistoryController controller) {
    return Expanded(
      child: ListView.builder(
        itemCount: controller.histories.length,
        itemBuilder: (context, index) {
          // Check transaction is pay balance to wallet
          controller.getHistoryPayBalance(index);

          final history = controller.histories[index];
          final amount = history.status == Message.REFUNDED
              ? history.info.refundAmount
              : history.requestParams.buyItems == null
                  ? history.requestParams.amount
                  : history.info.merchant.price;
          final quantity = history.requestParams.buyItems == null
              ? 1
              : history.requestParams.buyItems[0].quantity;
          final totalAmount =
              history.status == Message.REFUNDED ? amount : amount * quantity;

          return Container(
            margin: EdgeInsets.only(
              left: kPaddingTopup,
              right: kPaddingTopup,
              bottom: kPaddingTopup,
            ),
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(kBorderRadius),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: kPaddingTopup * .7,
                vertical: kPaddingTopup / 2,
              ),
              child: Container(
                height: 50,
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(kPaddingTopup / 3),
                      child: Container(
                        width: 45,
                        height: 30,
                        child: Image.asset(
                          'assets/icons/viettel.png', //'assets/icons/icon_default.jpg',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    SizedBox(width: kPaddingTopup / 2),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Viettel',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                '$totalAmountđ',
                                style: TextStyle(
                                  color:
                                      controller.getItemColor(history.status),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                controller.convertTimeStampToStringDate(
                                    history.createdAt),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                controller.getItemStatus(history.status),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: kPaddingTopup / 2),
                    Row(
                      children: [
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: appColor,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildNodataWidget() {
    return Expanded(
      child: Center(
        child: Text(
          'Không có dữ liệu',
          style: TextStyle(
            color: Colors.black26,
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  Widget _buildDateForm({@required String title, Function onTap}) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: kPaddingTopup,
          ),
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(kBorderRadius),
            color: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.black45,
                ),
              ),
              Image.asset(
                'assets/icons/icon_calendar.png',
                width: 30,
                height: 30,
              )
            ],
          ),
        ),
      ),
    );
  }

  void _buildPickerDatetime(
      {BuildContext context, HistoryController controller, bool isFromDate}) {
    DatePicker.showDateTimePicker(
      context,
      showTitleActions: true,
      minTime: DateTime(2021, 1, 1, 24, 00),
      maxTime: DateTime.now(),
      onChanged: (date) {},
      onConfirm: (date) {
        controller.setDate(date, isFromDate);
      },
      currentTime: DateTime.now(),
      locale: LocaleType.en,
    );
  }
}
