// ignore_for_file: deprecated_member_use

// import "package:flutter/services.dart";
// import "package:purchases_flutter/purchases_flutter.dart";

// class PurchaseAPI {
//   static const _apiKey = '';
//   static Future<void> init() async {
//     await Purchases.setDebugLogsEnabled(true);
//     await Purchases.setup(_apiKey);
//     await PurchasesConfiguration(_apiKey);
//   }

//   static Future<List<Offering>> getOffers() async {
//     try {
//       Offerings offerings = await Purchases.getOfferings();
//       Offering? current = offerings.current;
//       return current == null ? [] : [current];
//     } on PlatformException catch (_) {
//       rethrow;
//     }
//   }
// }
