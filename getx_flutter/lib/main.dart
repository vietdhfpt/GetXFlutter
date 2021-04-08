import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:getx_flutter/constants.dart';
import 'package:getx_flutter/pages/home/home_page.dart';

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
