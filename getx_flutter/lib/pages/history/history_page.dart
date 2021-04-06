import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_flutter/constants.dart';
import 'package:getx_flutter/models/topup_history.dart';
import 'package:getx_flutter/pages/history/history_controller.dart';
import 'package:intl/intl.dart';

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
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                      kBorderRadius,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    // padding: EdgeInsets.only(top: kPaddingTopup),
                    itemCount: controller.histories.length,
                    itemBuilder: (context, index) {
                      final history = controller.histories[index];
                      final amount = history.status == Message.REFUNDED
                          ? history.info.refundAmount
                          : history.info.merchant.price;
                      final quantity = history.requestParams.buyItems != null
                          ? history.requestParams.buyItems[0].quantity
                          : 1;
                      final totalAmount = amount * quantity;

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
                                  borderRadius:
                                      BorderRadius.circular(kPaddingTopup / 3),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Viettel - $index',
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
                                                  _getItemColor(history.status),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            _convertTimeStampToStringDate(
                                                history.createdAt),
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12,
                                            ),
                                          ),
                                          Text(
                                            _getItemStatus(history.status),
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
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Color _getItemColor(Message status) {
    switch (status) {
      case Message.SUCCESS:
        return Colors.green[400];
      case Message.REFUNDED:
        return Colors.grey;
      default:
        return Colors.red[200];
    }
  }

  String _getItemStatus(Message status) {
    switch (status) {
      case Message.SUCCESS:
        return 'Thành công'; //'Success';
      case Message.REFUNDED:
        return 'Hoàn lại'; //'Refunded';
      default:
        return 'Không thành công'; //'Failed';
    }
  }

  String _convertTimeStampToStringDate(int timestamp) {
    final date = new DateTime.fromMicrosecondsSinceEpoch(timestamp * 1000);
    return DateFormat('HH:mm dd/MM/yyyy').format(date);
  }
}
