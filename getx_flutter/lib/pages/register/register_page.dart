import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_flutter/pages/register/register_controller.dart';

class RegisterPage extends GetView<RegisterController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: controller.obx(
        (response) {
          return Center(child: Text(response.data));
        },
        onLoading: Center(child: CupertinoActivityIndicator()),
        onEmpty: Center(child: Text('Data is empty')),
        onError: (error) => Center(child: Text(error)),
      ),
    );
  }
}
