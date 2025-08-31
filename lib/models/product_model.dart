class Product {
  final int id;
  final String name;
  final String imageUrl;
  final String affiliateUrlCoupang;
  final String affiliateUrlAmazon;
  final String recommendation;
  final Map<String, dynamic> attributes;

  Product({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.affiliateUrlCoupang,
    required this.affiliateUrlAmazon,
    required this.recommendation,
    required this.attributes,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      affiliateUrlCoupang: json['affiliateUrlCoupang'],
      affiliateUrlAmazon: json['affiliateUrlAmazon'],
      recommendation: json['recommendation'],
      attributes: json['attributes'],
    );
  }
}