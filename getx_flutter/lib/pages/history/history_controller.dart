import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_flutter/models/topup_history.dart';
import 'package:getx_flutter/repository/topup_repository.dart';

class HistoryController extends GetxController {
  var _isLoading = false.obs;
  List<Datum> _histories = List<Datum>().obs;

  bool get isLoading => _isLoading.value;
  List<Datum> get histories => _histories;

  @override
  void onInit() {
    _recieveHistory(
        fromDate: '2021-04-03 00:00:00', toDate: '2021-04-06 00:00:00');
    super.onInit();
  }

  void _recieveHistory({String fromDate, String toDate}) async {
    try {
      _isLoading.value = true;
      final historyResp =
          await TopupRepository.instance.getHistories(fromDate, toDate);
      if (historyResp != null) {
        _histories.addAll(historyResp.data);
      }
    } finally {
      _isLoading.value = false;
    }
  }
}
