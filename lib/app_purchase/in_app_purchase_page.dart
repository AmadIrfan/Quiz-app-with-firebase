import 'package:flutter/material.dart';
import 'package:flutter_logical_quiz/app_purchase/IAP.dart';
import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

import '../model/topic_model.dart';
import '../provider/login_controller.dart';
import '../app_purchase/dash_purchases.dart';

class PurchasePage extends StatefulWidget {
  PurchasePage({
    super.key,
    required this.loginController,
    required this.topicModel,
  });
  final TopicModel topicModel;
  final LoginController loginController;

  @override
  State<PurchasePage> createState() => _PurchasePageState();
}

class _PurchasePageState extends State<PurchasePage> {
//   @override
  late final inAPpController;
  @override
  void initState() {
    super.initState();
    inAPpController = Get.put(DashPurchases(topicModel: widget.topicModel));
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Purchase Store'),
        ),
        body: FutureBuilder(
          future: inAPpController.loadPurchases(),
          builder: (context, _) {
            if (_.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
            if (inAPpController.products.isEmpty) {
              return Center(
                child: Text(
                  'No Offers Available',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              );
            }
            return ListView.builder(
              itemCount: inAPpController.products.length,
              itemBuilder: (BuildContext context, int index) {
                final item = inAPpController.products[index];
                return Card(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    margin: EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          // Added Expanded widget to allow the text to expand
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.title,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              Text('Price ${item.price}'),
                              Text(item.description),
                            ],
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            final data = await inAPpController.buy(
                              inAPpController.products[index],
                            );
                            // print(data);
                          },
                          child: Text('Buy'),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
