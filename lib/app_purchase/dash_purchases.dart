import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_logical_quiz/app_purchase/fire_base_methods.dart';
import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import '../app_purchase/IAP.dart';
import '../model/topic_model.dart';
import '../ui/quiz_page.dart';
import '../utility/constants.dart';

class DashPurchases extends GetxController {
  List<ProductDetails> products = [];
  late TopicModel topicModel;

  final List<PurchaseDetails> _purchases = [];
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  InAppPurchase iapConnection = IAPConnection.instance;

  DashPurchases({required this.topicModel}) {
    final purchaseUpdated = iapConnection.purchaseStream;
    _subscription = purchaseUpdated.listen(
      _onPurchaseUpdate,
      onDone: _updateStreamOnDone,
      onError: _updateStreamOnError,
    );
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  Future<void> buy(ProductDetails product) async {
    PurchaseParam param = GooglePlayPurchaseParam(
      productDetails: product,
    );

    final response = await iapConnection.buyNonConsumable(purchaseParam: param);
    Future.value(response);
  }

  void _onPurchaseUpdate(List<PurchaseDetails> purchaseDetailsList) async {
    _purchases.addAll(purchaseDetailsList);
    purchaseDetailsList.forEach(
      (purchaseDetails) async {
        if (purchaseDetails.status == PurchaseStatus.pending) {
        } else if (purchaseDetails.status == PurchaseStatus.error) {
          print(purchaseDetails.status);
        } else if (purchaseDetails.status == PurchaseStatus.purchased) {
          showSnackBar(purchaseDetails.status.name);
          pushPage(
            QuizPage(
              isFirstPurchased: true,
              topicModel: topicModel,
            ),
            function: (value) {
              if (value != null && value) {}
            },
          );
          await FirebaseMethod().updateStatus();
          print(purchaseDetails.status);
        } else if (purchaseDetails.status == PurchaseStatus.canceled) {
          showSnackBar(purchaseDetails.status.name);
        }
        print(purchaseDetails.status);
      },
    );
  }

  Future<void> loadPurchases() async {
    final available = await iapConnection.isAvailable();

    if (!available) {
      return;
    }
    const ids = <String>{'multiquiz'};
    ProductDetailsResponse response =
        await iapConnection.queryProductDetails(ids);
    for (var element in response.notFoundIDs) {
      debugPrint('Purchase $element not found');
    }
    products = response.productDetails;
  }

  void _updateStreamOnDone() {
    _subscription.cancel();
  }

  void _updateStreamOnError(dynamic error) {
    _subscription.cancel();
    showSnackBar(error);
  }
}
