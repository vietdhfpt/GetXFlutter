import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SPSnackbar {
  static SPSnackbar instance = SPSnackbar();

  void show({
    @required String message,
    String title = 'TETE Thông báo',
    SnackPosition position = SnackPosition.BOTTOM,
  }) {
    Get.snackbar(
      title,
      message,
      backgroundColor: Colors.black87,
      colorText: Colors.white,
      messageText: Text(
        message,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
      snackPosition: position,
      animationDuration: Duration(milliseconds: 700),
    );
  }
}
