import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class HomeController extends GetxController {
  int counter = 0;

  void increment() {
    counter++;
    if (counter % 5 == 0) showSnackBar();
    update(counter < 11
        ? ['isActiveIncrement', 'isnotActiveIncrement']
        : ['isActiveIncrement']);
  }

  void showSnackBar() {
    Get.dialog(
      CupertinoAlertDialog(
        title: Text(
          'Please turn on network connection to continue using this app',
        ),
        actions: [
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: GestureDetector(
                onTap: () => Get.back(),
                child: Text(
                  'Close',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      barrierDismissible: false,
    );
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}

class ProductController extends GetxController {}
