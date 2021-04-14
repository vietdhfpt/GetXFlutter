import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_flutter/models/topup_product.dart';
import 'package:getx_flutter/pages/online_payment/model/topup.dart';
import 'package:getx_flutter/pages/topup_payment_detail/topup_payment_detail.dart';
import 'package:getx_flutter/repository/topup_repository.dart';
import 'package:getx_flutter/sp_logger.dart';
import 'package:getx_flutter/sp_snackar.dart';

class TopupItem {
  String title;
  List<Item> childs;
  String icon;

  TopupItem({
    this.title,
    this.childs,
    this.icon,
  });
}

class OnlinePaymentController extends GetxController {
  RxInt _selectedIndexTopup = 0.obs;
  RxInt _amount = 0.obs;
  RxInt _balance = 0.obs;
  RxInt _selectedIndexProvider = 0.obs;
  RxInt _selectedIndexProduct = 0.obs;
  RxInt _quantity = 1.obs;
  RxInt _accountType = 0.obs;
  RxBool _isInputQuantity = false.obs;
  var _topups = <Topup>[].obs;
  var _currentlyProducts = <Item>[].obs;
  var _currentlyProviders = <TopupItem>[].obs;

  // Cratch Cards
  var _viettelCratchCards = <Item>[].obs;
  var _vinaphoneCratchCards = <Item>[].obs;
  var _mobifoneCratchCards = <Item>[].obs;
  var _vietnamobileCratchCards = <Item>[].obs;
  var _beelineCratchCards = <Item>[].obs;
  var _cratchCards = <TopupItem>[].obs;

  // Cratch Cards
  var _viettelPayMobiles = <Item>[].obs;
  var _vinaphonePayMobiles = <Item>[].obs;
  var _mobifonePayMobiles = <Item>[].obs;
  var _vietnamobilePayMobiles = <Item>[].obs;
  var _beelinePayMobiles = <Item>[].obs;
  var _payMobiles = <TopupItem>[].obs;

  // Cratch Cards
  var _viettelAdvanceMobiles = <Item>[].obs;
  var _vinaphoneAdvanceMobiles = <Item>[].obs;
  var _mobifoneAdvanceMobiles = <Item>[].obs;
  var _vietnamobileAdvanceMobiles = <Item>[].obs;
  var _beelineAdvanceMobiles = <Item>[].obs;
  var _advanceMobiles = <TopupItem>[].obs;

  // Properties public
  List<Topup> get topups => _topups;
  List<Item> get currentlyProducts => _currentlyProducts;
  List<TopupItem> get currentlyProviders => _currentlyProviders;
  int get selectedIndexTopup => _selectedIndexTopup.value;
  int get amount => _amount.value;
  int get balance => _balance.value;
  int get selectedIndexProvider => _selectedIndexProvider.value;
  int get selectedIndexProduct => _selectedIndexProduct.value;
  int get quantity => _quantity.value;
  int get accountType => _accountType.value;
  bool get isInputQuantity => _isInputQuantity.value;
  TextEditingController phoneNumberController = TextEditingController();

  @override
  void onInit() {
    _topups.addAll(topupsStore);
    _receiveProducts();
    _receiveBalance();
    _resetQuantity();
    super.onInit();
  }

  void payment() {
    if (balance < amount) {
      SPSnackbar.instance.show(
        message: 'Số dư không đủ thanh toán.',
        position: SnackPosition.TOP,
      );
      return;
    }

    _showTopupPaymentDetail();
  }

  void _showTopupPaymentDetail() {
    var arguments = <String, dynamic>{
      'product': currentlyProducts[selectedIndexProduct],
      'quantity': quantity,
      'amount': amount,
      if (selectedIndexTopup == 1) 'accountType': accountType,
      if (selectedIndexTopup == 1) 'phoneNumber': phoneNumberController.text,
    };

    if (selectedIndexTopup == 1 &&
        !GetUtils.isPhoneNumber(phoneNumberController.text)) {
      SPSnackbar.instance.show(message: 'Số điện thoại không hợp lệ');
      return;
    }

    Get.to(() => TopupPaymentDetail(), arguments: arguments);
  }

  void processCalculateMoney({@required bool isIncrement}) {
    if (!isIncrement) {
      if (_quantity.value > 1) _quantity.value--;
    } else {
      if (_quantity.value < 10) _quantity.value++;
    }
    _getMoney();
  }

  void _getMoney() {
    _amount.value =
        _currentlyProducts[selectedIndexProduct].finalPrice * quantity;
  }

  void _resetQuantity() {
    _quantity.value = 1;
  }

  void selectedTopup(int index) {
    switch (index) {
      case 0:
        _isInputQuantity.value = true;
        break;
      default:
        _isInputQuantity.value = false;
        break;
    }
    _topups.refresh();
    _selectedIndexTopup = RxInt(index);
    selectedProvider(0);
    update();
  }

  void selectedProvider(int index) {
    _selectedIndexProvider = RxInt(index);
    _currentlyProducts.clear();
    _currentlyProviders.clear();
    switch (selectedIndexTopup) {
      case 0:
        _cratchCards.refresh();
        _currentlyProducts.addAll(_cratchCards[index].childs);
        _currentlyProviders.addAll(_cratchCards);
        break;
      case 1:
        accountType == 0 ? _advanceMobiles.refresh() : _payMobiles.refresh();
        _currentlyProducts.addAll(
          accountType == 0
              ? _advanceMobiles[index].childs
              : _payMobiles[index].childs,
        );
        _currentlyProviders
            .addAll(accountType == 0 ? _advanceMobiles : _payMobiles);
        break;
      default:
        break;
    }

    selectedProduct(0);
    _resetQuantity();
    _getMoney();
  }

  void selectedProduct(int index) {
    _currentlyProducts.refresh();
    _selectedIndexProduct = RxInt(index);
    _resetQuantity();
    _getMoney();
  }

  void setAccountType(int index) {
    _accountType.value = index;
    selectedProvider(0);
    update();
  }

  void _receiveBalance() async {
    var response = await TopupRepository.instance.getBalance();
    _balance.value = response != null ? response.data.balance : 0;
  }

  void reloadBalance(int newBalance) {
    _balance.value = newBalance;
  }

  void _receiveProducts() async {
    var response = await TopupRepository.instance.getProducts();
    if (response != null) {
      _parsesCratchCard(response).whenComplete(() {
        SPLogger.instance.verbose('Parse Thẻ cào thành công!');
        final tempCratchCards = [
          TopupItem(
            title: 'Viettel',
            childs: _viettelCratchCards,
            icon: 'assets/icons/viettel.png',
          ),
          TopupItem(
            title: 'Vinaphone',
            childs: _vinaphoneCratchCards,
            icon: 'assets/icons/vinaphone.png',
          ),
          TopupItem(
            title: 'Mobifone',
            childs: _mobifoneCratchCards,
            icon: 'assets/icons/mobifone.png',
          ),
          TopupItem(
            title: 'Vietnamobile',
            childs: _vietnamobileCratchCards,
            icon: 'assets/icons/vietnamobile.png',
          ),
          TopupItem(
            title: 'Beeline',
            childs: _beelineCratchCards,
            icon: 'assets/icons/beeline.png',
          ),
        ];
        _cratchCards.addAll(tempCratchCards);

        // Set the first time has data.
        _currentlyProviders.addAll(_cratchCards);
        _currentlyProducts.addAll(_cratchCards[0].childs);
        _getMoney();
      });

      _parsesAdvanceMobile(response).whenComplete(() {
        SPLogger.instance.verbose('Parse nạp điện thoại trả trước thành công!');
        final tempAdvanceMobiles = [
          TopupItem(
            title: 'Viettel',
            childs: _viettelAdvanceMobiles,
            icon: 'assets/icons/viettel.png',
          ),
          TopupItem(
            title: 'Vinaphone',
            childs: _vinaphoneAdvanceMobiles,
            icon: 'assets/icons/vinaphone.png',
          ),
          TopupItem(
            title: 'Mobifone',
            childs: _mobifoneAdvanceMobiles,
            icon: 'assets/icons/mobifone.png',
          ),
          TopupItem(
            title: 'Vietnamobile',
            childs: _vietnamobileAdvanceMobiles,
            icon: 'assets/icons/vietnamobile.png',
          ),
          TopupItem(
            title: 'Beeline',
            childs: _beelineAdvanceMobiles,
            icon: 'assets/icons/beeline.png',
          ),
        ];
        _advanceMobiles.addAll(tempAdvanceMobiles);
      });

      // Parse Pay Mobile
      _parsesPayMobile(response).whenComplete(() {
        SPLogger.instance.verbose('Parse nạp điện thoại trả sau thành công!');
        final tempPayMobiles = [
          TopupItem(
            title: 'Viettel',
            childs: _viettelPayMobiles,
            icon: 'assets/icons/viettel.png',
          ),
          TopupItem(
            title: 'Vinaphone',
            childs: _vinaphonePayMobiles,
            icon: 'assets/icons/vinaphone.png',
          ),
          TopupItem(
            title: 'Mobifone',
            childs: _mobifonePayMobiles,
            icon: 'assets/icons/mobifone.png',
          ),
          TopupItem(
            title: 'Vietnamobile',
            childs: _vietnamobilePayMobiles,
            icon: 'assets/icons/vietnamobile.png',
          ),
          TopupItem(
            title: 'Beeline',
            childs: _beelinePayMobiles,
            icon: 'assets/icons/beeline.png',
          ),
        ];
        _payMobiles.addAll(tempPayMobiles);
      });
    }
  }

  Future _parsesCratchCard(TopupProduct response) async {
    final cratchCards = response.data[0].items;
    for (var i = 0; i < cratchCards.length; i++) {
      var cratchCard = cratchCards[i];
      switch (cratchCard.providerName) {
        case ProviderName.VIETTEL:
          _viettelCratchCards.add(cratchCard);
          _sortListByPrice(_viettelCratchCards);
          break;
        case ProviderName.VINAPHONE:
          _vinaphoneCratchCards.add(cratchCard);
          _sortListByPrice(_vinaphoneCratchCards);
          break;
        case ProviderName.MOBIFONE:
          _mobifoneCratchCards.add(cratchCard);
          _sortListByPrice(_mobifoneCratchCards);
          break;
        case ProviderName.VIETNAM_MOBILE:
          _vietnamobileCratchCards.add(cratchCard);
          _sortListByPrice(_vietnamobileCratchCards);
          break;
        case ProviderName.BEELINE:
          _beelineCratchCards.add(cratchCard);
          _sortListByPrice(_beelineCratchCards);
          break;
        default:
          break;
      }
    }
  }

  Future _parsesAdvanceMobile(TopupProduct response) async {
    final advanceMobiles = response.data[2].items;
    for (var i = 0; i < advanceMobiles.length; i++) {
      var advanceMobile = advanceMobiles[i];
      switch (advanceMobile.providerName) {
        case ProviderName.VIETTEL:
          _viettelAdvanceMobiles.add(advanceMobile);
          _sortListByPrice(_viettelAdvanceMobiles);
          break;
        case ProviderName.VINAPHONE:
          _vinaphoneAdvanceMobiles.add(advanceMobile);
          _sortListByPrice(_vinaphoneAdvanceMobiles);
          break;
        case ProviderName.MOBIFONE:
          _mobifoneAdvanceMobiles.add(advanceMobile);
          _sortListByPrice(_mobifoneAdvanceMobiles);
          break;
        case ProviderName.VIETNAM_MOBILE:
          _vietnamobileAdvanceMobiles.add(advanceMobile);
          _sortListByPrice(_vietnamobileAdvanceMobiles);
          break;
        case ProviderName.BEELINE:
          _beelineAdvanceMobiles.add(advanceMobile);
          _sortListByPrice(_beelineAdvanceMobiles);
          break;
        default:
          break;
      }
    }
  }

  Future _parsesPayMobile(TopupProduct response) async {
    final payMobiles = response.data[3].items;
    for (var i = 0; i < payMobiles.length; i++) {
      var payMobile = payMobiles[i];
      switch (payMobile.providerName) {
        case ProviderName.VIETTEL:
          _viettelPayMobiles.add(payMobile);
          _sortListByPrice(_viettelPayMobiles);
          break;
        case ProviderName.VINAPHONE:
          _vinaphonePayMobiles.add(payMobile);
          _sortListByPrice(_vinaphonePayMobiles);
          break;
        case ProviderName.MOBIFONE:
          _mobifonePayMobiles.add(payMobile);
          _sortListByPrice(_mobifonePayMobiles);
          break;
        case ProviderName.VIETNAM_MOBILE:
          _vietnamobilePayMobiles.add(payMobile);
          _sortListByPrice(_vietnamobilePayMobiles);
          break;
        case ProviderName.BEELINE:
          _beelinePayMobiles.add(payMobile);
          _sortListByPrice(_beelinePayMobiles);
          break;
        default:
          break;
      }
    }
  }

  void _sortListByPrice(List<Item> items) {
    items.sort((a, b) => a.productValue.compareTo(b.productValue));
  }
}
