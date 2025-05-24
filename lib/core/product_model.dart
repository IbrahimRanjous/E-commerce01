import 'package:parse_server_sdk/parse_server_sdk.dart';

class ProductModel {
  final String objectId;
  final DateTime createdAt;
  final DateTime updatedAt;
  // ignore: non_constant_identifier_names
  final Map<String, dynamic> ACL;
  String title;
  String brand;
  bool isVerified;
  String price;
  double rating;
  String discount;
  int instock;
  String description;
  int reviews;
  String category;
  String priceRange;
  bool status;
  String image;

  ProductModel({
    required this.objectId,
    required this.createdAt,
    required this.updatedAt,
    // ignore: non_constant_identifier_names
    required this.ACL,
    required this.title,
    required this.brand,
    required this.isVerified,
    required this.price,
    required this.rating,
    required this.discount,
    required this.instock,
    required this.description,
    required this.reviews,
    required this.category,
    required this.priceRange,
    required this.status,
    required this.image,
  });

  /// Constructs a ProductModel instance from a ParseObject.
  factory ProductModel.fromParse(ParseObject parseObject) {
    return ProductModel(
      objectId: parseObject.get<String>('objectId') ?? 'No objectId',
      // Use the built-in createdAt and updatedAt if available.
      createdAt: parseObject.createdAt ?? DateTime.now(),
      updatedAt: parseObject.updatedAt ?? DateTime.now(),
      ACL: parseObject.get<Map<String, dynamic>>('ACL') ?? {},
      title: parseObject.get<String>('title') ?? '',
      brand: parseObject.get<String>('brand') ?? '',
      isVerified: parseObject.get<bool>('isVerified') ?? false,
      price: parseObject.get<String>('price') ?? '',
      rating: (parseObject.get<num>('rating') ?? 0).toDouble(),
      discount: parseObject.get<String>('discount') ?? '',
      instock: parseObject.get<int>('instock') ?? 0,
      description: parseObject.get<String>('description') ?? '',
      reviews: parseObject.get<int>('reviews') ?? 0,
      category: parseObject.get<String>('category') ?? '',
      priceRange: parseObject.get<String>('priceRange') ?? '',
      status: parseObject.get<bool>('status') ?? false,
      // Trim the image URL in case of any extra spaces.
      image: (parseObject.get<String>('image') ?? '').trim(),
    );
  }

  // Converts a JSON map into a ProductModel instance.
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      objectId: json['objectId'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      ACL: json['ACL'] as Map<String, dynamic>,
      title: json['title'] as String,
      brand: json['brand'] as String,
      isVerified: json['isVerified'] as bool,
      price: json['price'] as String,
      rating: (json['rating'] as num).toDouble(),
      discount: json['discount'] as String,
      instock: json['instock'] as int,
      description: json['description'] as String,
      reviews: json['reviews'] as int,
      category: json['category'] as String,
      priceRange: json['priceRange'] as String,
      status: json['status'] as bool,
      image: (json['image'] as String).trim(), // Trim in case of extra spaces.
    );
  }

  // Converts a ProductModel instance back to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'objectId': objectId,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'ACL': ACL,
      'title': title,
      'brand': brand,
      'isVerified': isVerified,
      'price': price,
      'rating': rating,
      'discount': discount,
      'instock': instock,
      'description': description,
      'reviews': reviews,
      'category': category,
      'priceRange': priceRange,
      'status': status,
      'image': image,
    };
  }

  /// Factory constructor to create an empty ProductModel.
  factory ProductModel.empty() {
    return ProductModel(
      objectId: '',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      ACL: {},
      title: '',
      brand: '',
      isVerified: false,
      price: '',
      rating: 0.0,
      discount: '',
      instock: 0,
      description: '',
      reviews: 0,
      category: '',
      priceRange: '',
      status: false,
      image: '',
    );
  }
}
