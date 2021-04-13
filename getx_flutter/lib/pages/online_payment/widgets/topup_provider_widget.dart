import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_flutter/constants.dart';
import 'package:getx_flutter/pages/online_payment/online_payment_controller.dart';

class TopupProviderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 132,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(kBorderRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.all(kPaddingTopup),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  'Nhà mạng',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Container(
              height: 55,
              child: GetX<OnlinePaymentController>(
                builder: (controller) {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.currentlyProviders.length,
                    itemBuilder: (BuildContext context, int index) {
                      final model = controller.currentlyProviders[index];
                      return GestureDetector(
                        onTap: () {
                          controller.selectedProvider(index);
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: kPaddingTopup),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: controller.selectedIndexProvider == index
                                    ? appColor
                                    : Colors.grey[300],
                                width: controller.selectedIndexProvider == index
                                    ? 2.5
                                    : 1.5,
                              ),
                            ),
                            width: 90,
                            child: Center(
                              child: Image.asset(
                                model.icon,
                                width: 43,
                                height: 25,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
