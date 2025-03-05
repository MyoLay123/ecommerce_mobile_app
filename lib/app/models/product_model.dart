class ProductModel {
  int? id;
  String? name;
  String? description;
  String? brand;
  String? imageUrl;
  double? price;
  bool? rating;
  List? sizes;

  ProductModel({
    this.id,
    required this.name,
    required this.description,
    required this.brand,
    required this.imageUrl,
    required this.price,
    required this.rating,
    required this.sizes,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      brand: json['brand'],
      imageUrl: json['imageUrl'],
      price: json['price'].toDouble(),
      rating: json['rating'],
      sizes: json['sizes'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'brand': brand,
      'imageUrl': imageUrl,
      'price': price,
      'rating': rating,
      'sizes': sizes,
    };
  }
}
