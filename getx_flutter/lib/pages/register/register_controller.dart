import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getx_flutter/models/topup_register.dart';
import 'package:getx_flutter/pages/home/home_page.dart';
import 'package:getx_flutter/repository/topup_repository.dart';

class RegisterController extends GetxController with StateMixin<TopupRegister> {
  @override
  void onInit() {
    _register();
    super.onInit();
  }

  void _register() async {
    change(null, status: RxStatus.loading());
    var topupResponse = await TopupRepository.instance
        .register(shopId: 'fff16bdf-38ba-4253-af98-eef2d9bf6679');
    if (topupResponse != null) {
      GetStorage tokenStorage = GetStorage();
      tokenStorage.write('TOPUP_TOKEN', topupResponse.data);
      change(topupResponse, status: RxStatus.success());
      Get.off(() => HomePage());
    } else
      change(null, status: RxStatus.empty());
  }
}
