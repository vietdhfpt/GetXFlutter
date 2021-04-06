import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:getx_flutter/models/topup_product.dart';
import 'package:getx_flutter/pages/home/home_controller.dart';
import 'package:getx_flutter/pages/online_payment/model/topup.dart';
import 'package:getx_flutter/pages/topup_payment_detail/topup_payment_detail.dart';
import 'package:getx_flutter/repository/topup_repository.dart';
import 'package:getx_flutter/sp_logger.dart';
import 'package:getx_flutter/sp_snackar.dart';

class OnlinePaymentController extends GetxController {
  RxInt _selectedIndex = 0.obs;
  RxInt _amount = 0.obs;
  RxInt _balance = 0.obs;
  RxInt _selectedIndexProvider = 0.obs;
  RxInt _selectedIndexProduct = 0.obs;
  RxInt _quantity = 1.obs;

  var _topups = List<Topup>().obs;
  var _viettelCratchCards = List<Item>().obs;
  var _vinaphoneCratchCards = List<Item>().obs;
  var _mobifoneCratchCards = List<Item>().obs;
  var _vietnamobileCratchCards = List<Item>().obs;
  var _beelineCratchCards = List<Item>().obs;
  var _cratchCards = List<CratchCard>().obs;
  var _currentlyProducts = List<Item>().obs;

  // Properties public
  List<Topup> get topups => _topups;
  List<CratchCard> get cratchCards => _cratchCards;
  List<Item> get currentlyProducts => _currentlyProducts;

  int get selectedIndex => _selectedIndex.value;
  int get amount => _amount.value;
  int get balance => _balance.value;
  int get selectedIndexProvider => _selectedIndexProvider.value;
  int get selectedIndexProduct => _selectedIndexProduct.value;
  int get quantity => _quantity.value;

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
      'amount': amount
    };
    Get.to(() => TopupPaymentDetail(), arguments: arguments);
  }

  void processCalculateMoney({@required bool isIncrement}) {
    if (!isIncrement) {
      if (_quantity > 1) _quantity.value--;
    } else {
      if (_quantity < 10) _quantity.value++;
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
    _topups.refresh();
    _selectedIndex = RxInt(index);
  }

  void selectedProvider(int index) {
    _cratchCards.refresh();
    _selectedIndexProvider = RxInt(index);
    _currentlyProducts.clear();
    _currentlyProducts.addAll(_cratchCards[index].childs);
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
          CratchCard(
            title: 'Viettel',
            childs: _viettelCratchCards,
            icon: 'assets/icons/viettel.png',
          ),
          CratchCard(
            title: 'Vinaphone',
            childs: _vinaphoneCratchCards,
            icon: 'assets/icons/vinaphone.png',
          ),
          CratchCard(
            title: 'Mobifone',
            childs: _mobifoneCratchCards,
            icon: 'assets/icons/mobifone.png',
          ),
          CratchCard(
            title: 'Vietnamobile',
            childs: _vietnamobileCratchCards,
            icon: 'assets/icons/vietnamobile.png',
          ),
          CratchCard(
            title: 'Beeline',
            childs: _beelineCratchCards,
            icon: 'assets/icons/beeline.png',
          ),
        ];
        _cratchCards.addAll(tempCratchCards);

        // Set the first time has data.
        _currentlyProducts.addAll(_cratchCards[0].childs);
        _getMoney();
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

  void _sortListByPrice(List<Item> items) {
    items.sort((a, b) => a.productValue.compareTo(b.productValue));
  }
}
