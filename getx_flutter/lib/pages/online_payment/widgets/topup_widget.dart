import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:getx_flutter/constants.dart';
import 'package:getx_flutter/pages/online_payment/online_payment_controller.dart';
import 'package:get/get.dart';

class TopupWidget extends GetView<OnlinePaymentController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 66,
      child: Obx(() {
        return ListView.builder(
          padding: const EdgeInsets.only(left: kPaddingTopup),
          scrollDirection: Axis.horizontal,
          itemCount: controller.topups.length,
          itemBuilder: (BuildContext context, int index) {
            final model = controller.topups[index];
            return GestureDetector(
              onTap: () {
                controller.selectedTopup(index);
              },
              child: Padding(
                padding: const EdgeInsets.only(right: kPaddingTopup),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: controller.selectedIndex == index
                          ? appColor
                          : Colors.white,
                      width: 2,
                    ),
                  ),
                  width: 103,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          model.icon,
                          width: 22,
                          height: 25,
                          fit: BoxFit.fill,
                        ),
                        Text(
                          model.title,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
