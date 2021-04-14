import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_flutter/constants.dart';
import 'package:getx_flutter/pages/history/history_page.dart';
import 'package:getx_flutter/pages/home/home_controller.dart';
import 'package:getx_flutter/pages/online_payment/online_payment_page.dart';

class HomePage extends StatelessWidget {
  final HomeController _controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Topup'),
      ),
      resizeToAvoidBottomInset: false,
      body: DefaultTabController(
        length: _controller.choices.length,
        child: Column(
          children: [
            Container(
              constraints: BoxConstraints(maxHeight: 150.0),
              child: Material(
                color: topupBackGroundColor,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: kPaddingTopup),
                  child: TabBar(
                    indicatorColor: appColor,
                    tabs: _controller.choices.map<Widget>((choice) {
                      return Tab(
                        child: Text(
                          choice.title,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  OnlinePaymentPage(),
                  HistoryPage(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
