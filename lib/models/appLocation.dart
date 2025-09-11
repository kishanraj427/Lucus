class AppLocation {
  final double latitude;
  final double longitude;
  final String pinCode;
  final String street;
  final String city;
  final String state;
  final String country;

  AppLocation({
    required this.latitude,
    required this.longitude,
    required this.street,
    required this.city,
    required this.state,
    required this.country,
    required this.pinCode,
  });

  factory AppLocation.fromJson(Map<String, dynamic> json) {
    return AppLocation(
      latitude: json['latitude'],
      longitude: json['longitude'],
      street: json['street'],
      city: json['city'],
      state: json['state'],
      country: json['country'],
      pinCode: json['pinCode'],
    );
  }

  toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'street': street,
      'city': city,
      'state': state,
      'country': country,
      'pinCode': pinCode,
    };
  }
}
