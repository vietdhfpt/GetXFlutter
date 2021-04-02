import 'package:get/get.dart';
import 'package:getx_flutter/models/topup_product.dart';
import 'package:getx_flutter/pages/home/model/choice.dart';

class CratchCard {
  String title;
  List<Item> childs;
  String icon;

  CratchCard({
    this.title,
    this.childs,
    this.icon,
  });
}

class HomeController extends GetxController with StateMixin<TopupProduct> {
  var _choices = List<Choice>().obs;

  // Properties public
  List<Choice> get choices => _choices;

  @override
  void onInit() {
    super.onInit();
    _choices.addAll(choicesStore);
  }
}
