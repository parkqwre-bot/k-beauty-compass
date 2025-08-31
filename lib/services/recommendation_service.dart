import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../models/product_model.dart';

class RecommendationService {
  Future<List<Product>> getRecommendations(Map<int, List<int>> answers) async {
    if (kDebugMode) {
      print("--- New Recommendation Service Start ---");
      print("Received answers: $answers");
    }

    final String jsonString = await rootBundle.loadString('assets/product_database.json');
    final Map<String, dynamic> data = json.decode(jsonString);
    final List<dynamic> allProductsJson = data['products'];
    final List<Product> allProducts =
        allProductsJson.map((p) => Product.fromJson(p)).toList();

    // --- Determine User's Profile from Answers ---
    // Question 2: Skin Feel -> skin_type
    String? userSkinType;
    final skinFeelAnswer = answers[1]?.first;
    if (skinFeelAnswer != null) {
      if (skinFeelAnswer == 0) userSkinType = 'dry';
      if (skinFeelAnswer == 1) userSkinType = 'normal';
      if (skinFeelAnswer == 2) userSkinType = 'oily';
    }

    // Question 4: Sensitivity -> skin_type (overrides previous)
    final sensitivityAnswer = answers[3]?.first;
    if (sensitivityAnswer == 0 || sensitivityAnswer == 1) {
      userSkinType = 'sensitive';
    }

    // Question 3: Skin Worries -> concerns
    final List<String> userConcerns = [];
    final concernAnswers = answers[2];
    if (concernAnswers != null) {
      for (var answer in concernAnswers) {
        switch (answer) {
          case 0:
            userConcerns.add('acne');
            break;
          case 1:
            userConcerns.add('pores');
            break;
          case 2:
            userConcerns.add('wrinkles');
            break;
          case 3:
            userConcerns.add('redness');
            break;
          case 4:
            userConcerns.add('dullness');
            break;
        }
      }
    }

    if (kDebugMode) {
      print("User Profile - Skin Type: $userSkinType, Concerns: $userConcerns");
    }

    // --- Filter Products ---
    final List<Product> recommendedProducts = allProducts.where((product) {
      final productAttributes = product.attributes;
      bool skinTypeMatch = false;
      bool concernMatch = false;

      // Check for skin type match
      if (userSkinType == null) {
        skinTypeMatch = true; // If user is unsure, don't filter by skin type
      } else {
        final productSkinTypes = productAttributes['skin_type'] as List<dynamic>?;
        if (productSkinTypes != null &&
            (productSkinTypes.contains(userSkinType) ||
                productSkinTypes.contains('all'))) {
          skinTypeMatch = true;
        }
      }

      // Check for concern match
      if (userConcerns.isEmpty) {
        concernMatch = true; // If user has no concerns, don't filter by them
      } else {
        final productConcerns = productAttributes['concerns'] as List<dynamic>?;
        if (productConcerns != null) {
          for (var concern in userConcerns) {
            if (productConcerns.contains(concern)) {
              concernMatch = true;
              break; // Found at least one match
            }
          }
        }
      }

      return skinTypeMatch || concernMatch;
    }).toList();

    if (kDebugMode) {
      print("Found ${recommendedProducts.length} matching products.");
      print("--- New Recommendation Service End ---");
    }

    return recommendedProducts;
  }
}