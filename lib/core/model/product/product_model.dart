class ProductModel {
  final String id;
  final String name;
  final String description;
  final double price;
  final String categoryId;
  final List<String> images;
  final bool isTrending;
  final int? stock;
  final bool isActive;

  const ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.categoryId,
    required this.images,
    required this.isTrending,
    this.stock,
    this.isActive = true,
  });

  // Products added from the customer side have no stock yet.
  bool get inStock => stock == null || stock! > 0;

  factory ProductModel.fromFirestore(String id, Map<String, dynamic> json) {
    return ProductModel(
      id: id,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      categoryId: json['categoryId'] ?? '',
      images: List<String>.from(json['images'] ?? []),
      isTrending: json['isTrending'] ?? false,
      stock: (json['stock'] as num?)?.toInt(),
      isActive: json['isActive'] ?? true,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'categoryId': categoryId,
      'images': images,
      'isTrending': isTrending,
      'stock': stock,
      'isActive': isActive,
    };
  }
}
