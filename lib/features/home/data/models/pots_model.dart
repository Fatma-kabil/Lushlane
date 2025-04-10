class Pot {
  final String name;
  final String description;
  final double price;

  final String shopName;
  final String location;
  final String image;

  Pot({
    required this.name,
    required this.description,
    required this.price,

    required this.shopName,
    required this.location,
    required this.image,
  });

  factory Pot.fromJson(Map<String, dynamic> json) {
    return Pot(
      name: json['name'],
      description: json['description'],
      price: json['price'].toDouble(),

      shopName: json['shop_name'],
      location: json['location'],
      image: json['image'],
    );
  }
}
