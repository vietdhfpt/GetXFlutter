import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:getx_flutter/pages/controller/home_controller.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter GetX'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GetBuilder<HomeController>(
              id: 'isActiveIncrement',
              init: HomeController(),
              builder: (value) {
                return Text(
                  '${value.counter}',
                  style: Theme.of(context).textTheme.headline2,
                );
              },
            ),
            SizedBox(height: 10),
            GetBuilder<HomeController>(
              id: 'isnotActiveIncrement',
              init: HomeController(),
              builder: (value) {
                return Text(
                  '${value.counter}',
                  style: Theme.of(context).textTheme.headline2,
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          homeController.increment();
          // Get.to(() => ProductPage());
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.blue,
      ),
    );
  }
}

class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  ProductController productController = Get.put(ProductController());
  HomeController homeController = Get.put(HomeController());

  @override
  void dispose() {
    super.dispose();
    homeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product'),
      ),
      body: Container(),
    );
  }
}
