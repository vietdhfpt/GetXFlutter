import 'package:get/get.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:getx_flutter/pages/home/home_controller.dart';
import 'package:getx_flutter/pages/register/register_controller.dart';
import 'package:getx_flutter/pages/topup_payment_detail/topup_payment_detail_controller.dart';

class ManagerBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterController>(() => RegisterController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<TopupPaymentDetailController>(() => TopupPaymentDetailController());
  }
}
