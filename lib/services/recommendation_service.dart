import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../models/product_model.dart';

class RecommendationService {
  Future<List<Product>> _loadProductDatabase() async {
    final String jsonString = await rootBundle.loadString('assets/product_database.json');
    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((json) => Product.fromJson(json)).toList();
  }

  Future<Map<String, Product>> getRecommendations(Map<int, List<int>> answers) async {
    final List<Product> allProducts = await _loadProductDatabase();
    Map<String, Product> recommendedRoutine = {};

    // Default products
    Product cleanser = allProducts.firstWhere((p) => p.tags.contains("all") && p.name.contains("Cleanser"), orElse: () => allProducts.first);
    Product serum = allProducts.firstWhere((p) => p.tags.contains("all") && p.tags.contains("serum"), orElse: () => allProducts.first);
    Product cream = allProducts.firstWhere((p) => p.tags.contains("all") && p.tags.contains("cream"), orElse: () => allProducts.first);

    // Logic for Question 1: Skin Type
    if (answers.containsKey(0)) {
      int skinTypeAnswer = answers[0]![0];
      if (skinTypeAnswer == 0) { // Dry
        cream = allProducts.firstWhere((p) => p.tags.contains("dry"), orElse: () => cream);
      } else if (skinTypeAnswer == 2) { // Oily
        cleanser = allProducts.firstWhere((p) => p.tags.contains("oily"), orElse: () => cleanser);
      }
    }

    // Logic for Question 2: Skin Concerns
    if (answers.containsKey(1)) {
      List<int> concerns = answers[1]!;
      if (concerns.contains(2)) { // Wrinkles
        serum = allProducts.firstWhere((p) => p.tags.contains("wrinkles"), orElse: () => serum);
      } else if (concerns.contains(0)) { // Acne
        serum = allProducts.firstWhere((p) => p.tags.contains("acne"), orElse: () => serum);
      }
    }

    recommendedRoutine["Cleanser"] = cleanser;
    recommendedRoutine["Serum"] = serum;
    recommendedRoutine["Cream"] = cream;

    return recommendedRoutine;
  }
}
