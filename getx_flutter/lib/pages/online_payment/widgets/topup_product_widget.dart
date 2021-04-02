import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_flutter/constants.dart';
import 'package:getx_flutter/pages/online_payment/online_payment_controller.dart';

class TopupProductWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 190,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(kBorderRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.all(kPaddingTopup),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Mệnh giá',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(height: kPaddingTopup),
            GetX<OnlinePaymentController>(builder: (controller) {
              final products = controller.currentlyProducts;
              final length = products.length;
              return Container(
                child: GridView.count(
                  padding: EdgeInsets.zero,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 3,
                  childAspectRatio: 1.5, // Set height for item
                  crossAxisSpacing: kPaddingTopup,
                  mainAxisSpacing: kPaddingTopup,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  children: List.generate(length, (index) {
                    return GestureDetector(
                      onTap: () {
                        controller.selectedProduct(index);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: controller.selectedIndexProduct == index
                                ? appColor
                                : Colors.grey[300],
                            width: 2.5,
                          ),
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              child: Center(
                                child: Text(
                                  '${products[index].productValue}',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                Divider(height: 1, color: Colors.black38),
                                SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Hoàn lại: ',
                                      style: TextStyle(
                                        fontSize: 10,
                                      ),
                                    ),
                                    Text(
                                      '${products[index].payBack()}',
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.pink,
                                      ),
                                    )
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
