import 'package:cloud_firestore/cloud_firestore.dart';

//Data Model
abstract class Owner{
  String id;
  String? name;
  String? state;
  String? city;
  String? country;
  GeoPoint? coordinates;
  String? areaCode;
  String? phoneNumber;
  String? fullAddress;
  String? about;
  List<String>? photoURL;
  List<String>? petIDs;


  Owner({
    required this.id,
    this.name,
    this.state,
    this.city,
    this.country,
    this.coordinates,
    this.areaCode,
    this.phoneNumber,
    this.fullAddress,
    this.about,
    this.photoURL,
    this.petIDs,
  });

  /*
  Owner.fromJson(Map<String, Object?> json)
      : this(
    id: json['id']! as String,
    name: json['name']! as String,
    state: json['state'] as String,
    city: json['city']! as String,
    country: json['country'] as String,
    coordinates: json['coordinates']! as GeoPoint,
    areaCode: json['areaCode'] as String,
    phoneNumber: json['phoneNumber'] as String,
    fullAddress: json['fullAddress'] as String,
    about: json['about'] as String,
    photoURL: json['photoURL'] as List<String>,
    petIDs: json['petIDs'] as List<String>,
  );

  *//*
    toJson():
    The toJson() does the opposite which is to map the data back into
    JSON format before we upload into Firebase.
    *//*

  Map<String, Object?> toJson() {
    return {
      'id' : id,
      'name': name,
      'state': state,
      'city': city,
      'country': country,
      'coordinates': coordinates,
      'areaCode': areaCode,
      'phoneNumber': phoneNumber,
      'fullAddress': fullAddress,
      'about': about,
      'photoURL': photoURL,
      'petIDs': petIDs,
    };
  }

    */

  factory Owner.fromSnapshot(DocumentSnapshot snapshot) {
    // TODO: implement Owner.fromSnapshot
    throw UnimplementedError();
  }

  /*
  factory Owner.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    String id = snapshot.id;
    String name = data['name'] as String;
    String? state = data['state'] as String;
    String? city = data['city'] as String;
    String? country = data['country'] as String;
    GeoPoint? coordinates = data['coordinates'] as GeoPoint;
    String? areaCode = data['areaCode'] as String;
    String? phoneNumber = data['phoneNumber'] as String;
    String? fullAddress = data['fullAddress'] as String;
    String? about = data['about'] as String;
    List<String>? photoURL = data['photoURL'] as List<String>;
    List<String>? petIDs = data['petIDs'] as List<String>;

    return Owner(
      id: id,
      name: name,
      state: state,
      city: city,
      country: country,
      coordinates: coordinates,
      areaCode: areaCode,
      phoneNumber: phoneNumber,
      fullAddress: fullAddress,
      about: about,
      photoURL: photoURL,
      petIDs: petIDs,
    );
  }

*/
}