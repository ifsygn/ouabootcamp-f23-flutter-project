class Address {
  final String street;
  final String city;

  String? building;
  String? state;
  String? country;
  String? fullAddress;
  String? areaCode;
  String? phoneNumber;

  Address({required this.street,
    required this.building,
    required this.city});

  Map<String, dynamic> toMap() {
    return {
      'streetName': street,
      'buildingName': building,
      'cityName': city,
    };
  }

  Address.fromMap(Map<String, dynamic> addressMap)
      : street = addressMap["streetName"],
        building = addressMap["buildingName"],
        city = addressMap["cityName"];
}