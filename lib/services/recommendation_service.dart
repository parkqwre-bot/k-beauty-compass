import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../models/product_model.dart';

class RecommendationService {

  Future<List<Product>> getRecommendations(Map<int, List<int>> answers) async {
    if (kDebugMode) {
      print("--- Recommendation Service Start ---");
      print("Received answers: $answers");
    }

    final String jsonString = await rootBundle.loadString('assets/product_database.json');
    final Map<String, dynamic> allData = json.decode(jsonString);
    final Map<String, dynamic> skinTypesData = allData['skin_types'];

    String concernKey = 'dry'; // Default key

    if (answers.containsKey(2) && answers[2]!.isNotEmpty) {
      int concernAnswer = answers[2]![0];
      switch (concernAnswer) {
        case 0: concernKey = 'acne'; break;
        case 1: concernKey = 'pore'; break;
        case 2: concernKey = 'antiaging'; break;
        case 3: concernKey = 'sensitive'; break;
        case 4: concernKey = 'antiaging'; break;
      }
    } else if (answers.containsKey(1) && answers[1]!.isNotEmpty) {
      int skinFeelAnswer = answers[1]![0];
      if (skinFeelAnswer == 0) {
        concernKey = 'dry';
      } else if (skinFeelAnswer == 2) {
        concernKey = 'acne';
      }
    }

    if (kDebugMode) {
      print("Determined concernKey: $concernKey");
    }

    String storeKey = 'coupang';
    if (answers.containsKey(0) && answers[0]!.isNotEmpty && answers[0]![0] == 1) {
      storeKey = 'amazon';
    }

    if (kDebugMode) {
      print("Determined storeKey: $storeKey");
    }

    final List<dynamic> recommendedProductsList = skinTypesData[concernKey]?[storeKey] ?? [];

    if (kDebugMode) {
      print("Found ${recommendedProductsList.length} products from JSON.");
    }

    if (recommendedProductsList.isNotEmpty) {
      final products = recommendedProductsList.map((json) => Product.fromJson(json)).toList();
      if (kDebugMode) {
        print("Successfully parsed products. Returning ${products.length} products.");
        print("--- Recommendation Service End ---");
      }
      return products;
    } else {
      if (kDebugMode) {
        print("No products found. Returning empty list.");
        print("--- Recommendation Service End ---");
      }
      return [];
    }
  }
}
