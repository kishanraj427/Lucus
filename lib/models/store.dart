class Store {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final String address;
  final double pricePerDay;
  final double rating;

  const Store({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.rating,
    required this.address,
    required this.pricePerDay,
  });

  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
      address: json['address'] as String,
      rating: (json['rating'] as num).toDouble(),
      pricePerDay: (json['pricePerDay'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'address': address,
      'rating': rating,
      'pricePerDay': pricePerDay,
    };
  }
}
