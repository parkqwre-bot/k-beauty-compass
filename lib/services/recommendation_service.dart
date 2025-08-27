import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../models/product_model.dart';

class RecommendationService {

  // This function now returns a List of Products, not a Map.
  Future<List<Product>> getRecommendations(Map<int, List<int>> answers) async {
    // 1. Load and decode the JSON
    final String jsonString = await rootBundle.loadString('assets/product_database.json');
    final Map<String, dynamic> allData = json.decode(jsonString);
    final Map<String, dynamic> skinTypesData = allData['skin_types'];

    // 2. Determine the user's primary concern from the quiz answers
    String concernKey = 'dry'; // Default key

    // Prioritize the "Biggest Skin Worries" question (index 2)
    if (answers.containsKey(2) && answers[2]!.isNotEmpty) {
      int concernAnswer = answers[2]![0]; // Use the first selected concern
      switch (concernAnswer) {
        case 0: // 여드름/뾰루지 (Acne/Blemishes)
          concernKey = 'acne';
          break;
        case 1: // 모공 (Pores)
          concernKey = 'pore';
          break;
        case 2: // 주름 (Wrinkles)
          concernKey = 'antiaging';
          break;
        case 3: // 홍조 (Redness)
          concernKey = 'sensitive';
          break;
        case 4: // 칙칙함 (Dullness)
          concernKey = 'antiaging';
          break;
      }
    }
    // Fallback to the "Skin Feel" question (index 1) if no primary concern is selected
    else if (answers.containsKey(1) && answers[1]!.isNotEmpty) {
        int skinFeelAnswer = answers[1]![0];
        if (skinFeelAnswer == 0) { // 건조하고 당김 (Tight and Dry)
            concernKey = 'dry';
        } else if (skinFeelAnswer == 2) { // 번들거리고 유분기 있음 (Shiny and Oily)
            concernKey = 'acne';
        }
    }

    // 3. Determine the country for store selection from question index 0
    String storeKey = 'coupang'; // Default to Coupang
    if (answers.containsKey(0) && answers[0]!.isNotEmpty && answers[0]![0] == 1) { // 1 is United States
      storeKey = 'amazon';
    }

    // 4. Retrieve the list of product maps
    final List<dynamic> recommendedProductsList = skinTypesData[concernKey]?[storeKey] ?? [];

    // 5. Map the list of maps to a List<Product>
    if (recommendedProductsList.isNotEmpty) {
      return recommendedProductsList.map((json) => Product.fromJson(json)).toList();
    } else {
      // Return an empty list if no products are found for the given criteria
      return [];
    }
  }
}