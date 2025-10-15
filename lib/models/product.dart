class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final List<String> images;
  final List<String> tags;
  final int stock;
  final bool featured;
  final DateTime createdAt;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.images,
    required this.tags,
    required this.stock,
    required this.featured,
    required this.createdAt,
  });

  factory Product.fromFirestore(Map<String, dynamic> data, String id) {
    return Product(
      id: id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      price: (data['price'] ?? 0).toDouble(),
      imageUrl: data['imageUrl'] ?? '',
      images: List<String>.from(data['images'] ?? []),
      tags: List<String>.from(data['tags'] ?? []),
      stock: data['stock'] ?? 0,
      featured: data['featured'] ?? false,
      createdAt: data['createdAt'] != null
          ? DateTime.parse(data['createdAt'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'images': images,
      'tags': tags,
      'stock': stock,
      'featured': featured,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
