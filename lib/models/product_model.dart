class Product {
  final String name;
  final String recommendation;
  final String imageUrl;
  final String affiliateUrl;

  Product({
    required this.name,
    required this.recommendation,
    required this.imageUrl,
    required this.affiliateUrl,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'] ?? '',
      recommendation: json['recommendation'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      affiliateUrl: json['affiliateUrl'] ?? '',
    );
  }
}