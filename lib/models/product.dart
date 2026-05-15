/// Product model class
/// Represents a product from the FakeStore API
class Product {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final Rating? rating;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    this.rating,
  });

  /// Factory constructor to create Product from JSON
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0,
      title: json['title'] ?? 'Unknown Product',
      price: (json['price'] ?? 0).toDouble(),
      description: json['description'] ?? '',
      category: json['category'] ?? 'Unknown',
      image: json['image'] ?? '',
      rating: json['rating'] != null ? Rating.fromJson(json['rating']) : null,
    );
  }

  /// Convert Product to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'description': description,
      'category': category,
      'image': image,
      'rating': rating?.toJson(),
    };
  }
}

/// Rating model class
/// Represents product rating from FakeStore API
class Rating {
  final double rate;
  final int count;

  Rating({required this.rate, required this.count});

  /// Factory constructor to create Rating from JSON
  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      rate: (json['rate'] ?? 0).toDouble(),
      count: json['count'] ?? 0,
    );
  }

  /// Convert Rating to JSON
  Map<String, dynamic> toJson() {
    return {'rate': rate, 'count': count};
  }
}
