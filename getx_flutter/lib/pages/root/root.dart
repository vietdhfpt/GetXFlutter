import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getx_flutter/pages/home/home_page.dart';
import 'package:getx_flutter/pages/register/register_controller.dart';
import 'package:getx_flutter/pages/register/register_page.dart';

class Root extends GetWidget<RegisterController> {
  @override
  Widget build(BuildContext context) {
    return GetX(
      builder: (_) {
        GetStorage tokenStorage = GetStorage();
        String token = tokenStorage.read('TOPUP_TOKEN');
        if (token.isEmpty) {
          return RegisterPage();
        } else {
          return HomePage();
        }
      },
    );
  }
}
