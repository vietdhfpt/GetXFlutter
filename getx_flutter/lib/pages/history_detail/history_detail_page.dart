import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_flutter/constants.dart';
import 'package:getx_flutter/models/topup_history.dart';
import 'package:getx_flutter/pages/online_payment/online_payment_controller.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class HistoryDetailPage extends StatelessWidget {
  Datum data;

  @override
  Widget build(BuildContext context) {
    data = Get.arguments as Datum;
    return Scaffold(
      appBar: AppBar(
        title: Text('Chi tiết giao dịch'),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (data.info.note != null)
      return _buildPayBalance();
    else
      return _buildInfoBody();
  }

  Widget _buildPayBalance() {
    return Container(
      padding: const EdgeInsets.all(kPaddingTopup),
      color: topupBackGroundColor,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(
              bottom: kPaddingTopup,
            ),
            padding: EdgeInsets.all(kPaddingTopup),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(kBorderRadius),
            ),
            child: Column(
              children: [
                _buildStatus(),
                SizedBox(height: 10),
                _buildInfoCell(
                  title: 'Mã giao dịch',
                  value: data.requestId,
                  isTransactionId: true,
                ),
                Divider(height: 1, color: Colors.black26),
                _buildInfoCell(
                  title: 'Ngày giao dịch',
                  value: convertTimeStampToStringDate(data.createdAt),
                ),
                Divider(height: 1, color: Colors.black26),
                _buildInfoCell(title: 'Phí giao dịch', value: 'Miễn phí'),
                Divider(height: 1, color: Colors.black26),
                _buildInfoCell(
                  title: 'Giá',
                  value: '${_getTotalAmount(data)}đ',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoBody() {
    var softpins = [];
    if (data.status != Message.REFUNDED) {
      softpins = data.responseData.products == null
          ? []
          : data.responseData.products[0].softpins;
    }
    return Container(
      padding: const EdgeInsets.all(kPaddingTopup),
      color: topupBackGroundColor,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(
              bottom: kPaddingTopup,
            ),
            padding: EdgeInsets.all(kPaddingTopup),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(kBorderRadius),
            ),
            child: Column(
              children: [
                _buildStatus(),
                SizedBox(height: 10),
                _buildInfoCell(
                  title: 'Mã giao dịch',
                  value: data.requestId,
                  isTransactionId: true,
                ),
                Divider(height: 1, color: Colors.black26),
                _buildInfoCell(
                    title: 'Ngày giao dịch',
                    value: convertTimeStampToStringDate(data.createdAt)),
                Divider(height: 1, color: Colors.black26),
                _buildInfoCell(title: 'Nhà cung cấp', value: 'Viettel'),
                _contentPayMobile(),
                Divider(height: 1, color: Colors.black26),
                _buildInfoCell(title: 'Phí giao dịch', value: 'Miễn phí'),
                Divider(height: 1, color: Colors.black26),
                _buildInfoCell(
                    title: 'Giá', value: '${_getTotalAmount(data)}đ'),
                if (data.status != Message.REFUNDED)
                  _contentQuantityAndDiscount(),
              ],
            ),
          ),
          if (data.status != Message.REFUNDED)
            Expanded(
              child: CupertinoScrollbar(
                child: ListView.builder(
                  itemCount: softpins.length,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 80,
                      margin: const EdgeInsets.only(
                        bottom: kPaddingTopup,
                      ),
                      padding: EdgeInsets.all(kPaddingTopup),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(kBorderRadius),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Mã nạp:',
                                style: TextStyle(
                                  color: Colors.black45,
                                ),
                              ),
                              Text(
                                '${softpins[index].softpinSerial}',
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Số seri:',
                                style: TextStyle(
                                  color: Colors.black45,
                                ),
                              ),
                              Text(
                                '${softpins[index].softpinPinCode}',
                                style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _contentQuantityAndDiscount() {
    final quantity = data.requestParams.buyItems == null
        ? 0
        : data.requestParams.buyItems[0].quantity;
    return Column(
      children: [
        if (data.requestParams.buyItems != null)
          Divider(height: 1, color: Colors.black26),
        if (data.requestParams.buyItems != null)
          _buildInfoCell(title: 'Số lượng', value: '$quantity'),
        Divider(height: 1, color: Colors.black26),
        _buildInfoCell(
            title: 'Giảm giá', value: '${data.info.merchant.profit}'),
      ],
    );
  }

  Widget _contentPayMobile() {
    if (data.requestParams.accountType != '0') return Container();
    final accountTypeText =
        data.requestParams.accountType == '0' ? 'Trả trước' : 'Trả sau';
    return Column(
      children: [
        Divider(height: 1, color: Colors.black26),
        _buildInfoCell(
            title: 'Số điện thoại',
            value:
                '${data.requestParams.targetAccount.isEmpty ? null : data.requestParams.targetAccount}'),
        Divider(height: 1, color: Colors.black26),
        _buildInfoCell(title: 'Hình thức', value: '$accountTypeText'),
      ],
    );
  }

  Widget _buildStatus() {
    return Container(
      padding: const EdgeInsets.all(kPaddingTopup),
      decoration: BoxDecoration(
        color: getColorStatus(data.status).withAlpha(70),
        borderRadius: BorderRadius.circular(kBorderRadius),
      ),
      child: Row(
        children: [
          Icon(
            getIconStatus(data.status),
            color: getColorStatus(data.status),
            size: 20,
          ),
          SizedBox(width: kPaddingTopup / 2),
          Expanded(
            child: Text(
              getMessageStatus(data.status),
            ),
          ),
        ],
      ),
    );
  }

  Container _buildInfoCell({
    @required String title,
    String value,
    bool isTransactionId = false,
  }) {
    return Container(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.black45,
              fontWeight: FontWeight.w500,
            ),
          ),
          Container(
            constraints: BoxConstraints(maxWidth: Get.width * 0.7),
            child: Text(
              value,
              style: TextStyle(
                color: isTransactionId ? Colors.blue : Colors.black,
                fontWeight: FontWeight
                    .w500, //isTransactionId ? FontWeight.w500 : FontWeight.bold,
                fontSize: isTransactionId ? 14 : null,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String convertTimeStampToStringDate(int timestamp) {
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    final DateFormat formatter = DateFormat('HH:mm - dd/MM/yyyy');
    return formatter.format(date);
  }

  IconData getIconStatus(Message status) {
    switch (status) {
      case Message.SUCCESS:
        return Icons.check_circle;
      case Message.FAILED:
        return Icons.warning_sharp;
      default:
        return Icons.settings_backup_restore;
    }
  }

  Color getColorStatus(Message status) {
    Color color;
    switch (status) {
      case Message.SUCCESS:
        color = Colors.green;
        break;
      case Message.FAILED:
        color = Colors.red[300];
        break;
      default:
        color = Colors.grey;
        break;
    }

    return color;
  }

  String getMessageStatus(Message status) {
    switch (status) {
      case Message.SUCCESS:
        return data.info.merchant == null
            ? 'Nạp tiền vào ví thành công'
            : 'Giao dịch thành công';
      case Message.FAILED:
        return errorMessageValues.reverse[data.responseData.errorMessage] ?? '';
      default:
        return 'Hoàn tiền thành công';
    }
  }

  int _getTotalAmount(Datum data) {
    switch (data.status) {
      case Message.SUCCESS:
        return data.info.note != null
            ? data.requestParams.amount
            : data.info.merchant.price;
      case Message.FAILED:
        return data.info.merchant.price;
      default:
        return data.info.refundAmount;
    }
  }
}
