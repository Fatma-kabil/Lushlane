class PotsModel {
  final String name;
  final String description;
  final double price;
  final String shopName;
  final String location;
  final String image;
  final double rating; // New property for rating

  PotsModel({
    required this.name,
    required this.description,
    required this.price,
    required this.shopName,
    required this.location,
    required this.image,
    required this.rating, // Include rating in the constructor
  });

  factory PotsModel.fromJson(Map<String, dynamic> json) {
    return PotsModel(
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      price: json['price'] != null ? double.tryParse(json['price'].toString()) ?? 0.0 : 0.0,
      shopName: json['shop_name'] ?? '',
      location: json['location'] ?? '',
      image: json['image'] ?? '',
      rating: json['rating'] != null ? double.tryParse(json['rating'].toString()) ?? 0.0 : 0.0, // Parse rating
    );
  }
}
