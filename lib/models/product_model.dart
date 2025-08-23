class Product {
  final int id;
  final String name;
  final String brand;
  final List<String> tags;
  final String imageUrl;
  final String affiliateUrl;

  Product({
    required this.id,
    required this.name,
    required this.brand,
    required this.tags,
    required this.imageUrl,
    required this.affiliateUrl,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      brand: json['brand'],
      tags: List<String>.from(json['tags']),
      imageUrl: json['imageUrl'],
      affiliateUrl: json['affiliateUrl'],
    );
  }
}

