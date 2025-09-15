import 'package:flutter/foundation.dart';
import 'package:k_beauty_compass/product_data.dart';
import '../models/product_model.dart';

class RecommendationService {
  bool _isKorean(String text) {
    return RegExp(r'[\uAC00-\uD7AF\u1100-\u11FF\u3130-\u318F]').hasMatch(text);
  }

  Future<List<Product>> getRecommendations(
      Map<int, List<int>> answers, {required bool isUS}) async {
    if (kDebugMode) {
      print("--- New Recommendation Service Start ---");
      print("Received answers: $answers");
      print("User location isUS: $isUS");
    }

    // --- Determine User's Profile from Answers ---
    String? userSkinType;
    final skinFeelAnswer = answers[1]?.first;
    if (skinFeelAnswer != null) {
      if (skinFeelAnswer == 0) userSkinType = 'dry';
      if (skinFeelAnswer == 1) userSkinType = 'normal';
      if (skinFeelAnswer == 2) userSkinType = 'oily';
    }

    final sensitivityAnswer = answers[3]?.first;
    if (sensitivityAnswer == 0 || sensitivityAnswer == 1) {
      userSkinType = 'sensitive';
    }

    final List<String> userConcerns = [];
    final concernAnswers = answers[2];
    if (concernAnswers != null) {
      for (var answer in concernAnswers) {
        switch (answer) {
          case 0:
            userConcerns.add('acne');
            break;
          case 1:
            userConcerns.add('pore');
            break;
          case 2:
            userConcerns.add('anti-aging');
            break;
          case 3:
            userConcerns.add('sensitive');
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
    List<Product> recommendedProducts = allProducts.where((product) {
      final productAttributes = product.attributes;
      bool skinTypeMatch = false;
      bool concernMatch = false;

      if (userSkinType != null) {
        final productSkinType = productAttributes['skinType'] as String?;
        if (productSkinType != null && productSkinType == userSkinType) {
          skinTypeMatch = true;
        }
      } else {
        skinTypeMatch = true;
      }

      if (userConcerns.isNotEmpty) {
        final productSkinType = productAttributes['skinType'] as String?;
        if (productSkinType != null) {
          for (var concern in userConcerns) {
            if (productSkinType == concern) {
              concernMatch = true;
              break;
            }
          }
        }
      } else {
        concernMatch = true;
      }

      return skinTypeMatch || concernMatch;
    }).toList();

    // Filter by location
    if (isUS) {
      recommendedProducts = recommendedProducts
          .where((p) => p.affiliateUrlAmazon.isNotEmpty && !_isKorean(p.name))
          .toList();
    } else {
      recommendedProducts =
          recommendedProducts.where((p) => p.affiliateUrlCoupang.isNotEmpty).toList();
    }

    if (kDebugMode) {
      print("Found ${recommendedProducts.length} matching products.");
      print("--- New Recommendation Service End ---");
    }

    return recommendedProducts;
  }
}