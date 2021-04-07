import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:getx_flutter/constants.dart';
import 'package:getx_flutter/manager_bindings.dart';
import 'package:getx_flutter/pages/home/home_page.dart';
import 'package:getx_flutter/pages/register/register_page.dart';
import 'package:getx_flutter/pages/root/root.dart';
import 'package:getx_flutter/pages/topup_payment_detail/topup_payment_detail.dart';
import 'package:getx_flutter/pages/topup_payment_result/topup_result_payment.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter GetX',
      debugShowCheckedModeBanner: false,
      theme: theme,
      getPages: [],
      home: HomePage(),
    );
  }
}
