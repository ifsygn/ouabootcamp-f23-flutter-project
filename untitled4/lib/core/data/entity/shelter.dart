import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'address.dart';


//Data Model
class Shelter {
  final String shelterID;
  String? name;
  String? type;
  String? state;
  String? city;
  String? country;
  GeoPoint? coordinates;
  String? fullAddress;
  String? iBAN;
  String? about;
  int? numRatings;
  String? photo;
  String? areaCode;
  String? phoneNumber;
  Address? address;
  // Pet [] pets;

  Shelter({
    required this.shelterID,
    required this.name,
    required this.city,
    this.coordinates,
    this.type,
    this.phoneNumber,
  });

  /*
    fromMap(Map snapshot, String id):
    When data is fetched from Firebase, it is in JSON format.
    this method allows us to map data from JSON format to our Product format.
    */

  Shelter.fromMap(Map snapshot,String id) :
        shelterID = id ?? '',
        name = snapshot['name'] as String,
        city = snapshot['city'] as String,
        coordinates = snapshot['location'] as GeoPoint;

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "city": city,
      "location": coordinates,
    };
  }

  Shelter.fromJson(Map<String, Object?> json)
      : this(
    shelterID: json['shelterID']! as String,
    name: json['name']! as String,
    city: json['city']! as String,
    coordinates: json['location']! as GeoPoint,
  );

  /*
    toJson():
    The toJson() does the opposite which is to map the data back into
    JSON format before we upload into Firebase.
    */

  Map<String, Object?> toJson() {
    return {
      'name': name,
      'city': city,
      'location': coordinates,
    };
  }

  //contain data read from the document
  Shelter.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : shelterID = doc.id,
        name = doc.data()!["name"],
        city = doc.data()!["city"],
        coordinates = doc.data()!["location"],
        address = Address.fromMap(doc.data()!["address"]);
}