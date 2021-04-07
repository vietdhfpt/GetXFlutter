import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_flutter/models/topup_history.dart';
import 'package:getx_flutter/repository/topup_repository.dart';
import 'package:intl/intl.dart';

class HistoryController extends GetxController {
  var _isLoading = false.obs;
  List<Datum> _histories = List<Datum>().obs;
  var _fromDate = 0.obs;
  var _toDate = 0.obs;
  var _isNodataAvailable = false.obs;

  bool get isLoading => _isLoading.value;
  List<Datum> get histories => _histories;
  int get fromDate => _fromDate.value;
  int get toDate => _toDate.value;
  bool get isNodataAvailable => _isNodataAvailable.value;

  @override
  void onInit() {
    _setDefaultDate();
    _recieveHistory(
      fromDate: _fromDate.value,
      toDate: _toDate.value,
    );
    super.onInit();
  }

  void _setDefaultDate() {
    _fromDate.value = DateTime(2021, 01, 01, 00, 00).millisecondsSinceEpoch;
    _toDate.value = DateTime.now().millisecondsSinceEpoch;
  }

  void setDate(DateTime date, bool isFromDate) {
    final result = date.millisecondsSinceEpoch;
    if (isFromDate)
      _fromDate.value = result;
    else
      _toDate.value = result;

    _recieveHistory(fromDate: _fromDate.value, toDate: _toDate.value);
  }

  void _recieveHistory({int fromDate, int toDate}) async {
    try {
      _isLoading.value = true;
      final historyResp =
          await TopupRepository.instance.getHistories(fromDate, toDate);
      if (historyResp != null) {
        _histories.clear();
        final newHistory =
            historyResp.data.where((i) => i.status != Message.FAILED).toList();
        _histories.addAll(newHistory);
      }
      _isNodataAvailable.value = histories.isEmpty;
    } finally {
      _isLoading.value = false;
    }
  }

  Color getItemColor(Message status) {
    switch (status) {
      case Message.SUCCESS:
        return Colors.green[400];
      default:
        return Colors.red[200];
    }
  }

  String getItemStatus(Message status) {
    switch (status) {
      case Message.SUCCESS:
        return 'Thành công'; //'Success';
      default:
        return 'Hoàn lại';
    }
  }

  String convertTimeStampToStringDate(int timestamp) {
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    final DateFormat formatter = DateFormat('dd/MM/yyyy HH:mm');
    return formatter.format(date);
  }
}
