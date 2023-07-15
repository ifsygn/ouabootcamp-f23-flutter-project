import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled4/core/data/entity/owner.dart';

class Users extends Owner {
  final String surName;
  final String userName;
  final String email;
  final DateTime birthDate;

  Users({
    required String id,
    required String name,
    String? state,
    required String city,
    String? country,
    GeoPoint? coordinates,
    String? areaCode,
    String? phoneNumber,
    String? fullAddress,
    required this.surName,
    required this.userName,
    required this.email,
    required this.birthDate,
    required String about,
    List<String>? photoURL,
    List<String>? petIDs,
  }) : super(
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

  Users.fromJson(Map<String, Object?> json)
      : this(
    id: json['id']! as String,
    name: json['name']! as String,
    state: json['state'] as String?,
    city: json['city']! as String,
    country: json['country'] as String?,
    coordinates: json['coordinates']! as GeoPoint?,
    areaCode: json['areaCode'] as String?,
    phoneNumber: json['phoneNumber'] as String?,
    fullAddress: json['fullAddress'] as String?,
    surName: json['surName']! as String,
    userName: json['userName']! as String,
    email: json['email']! as String,
    birthDate: DateTime.parse(json['birthDate']! as String),
    about: json['about']! as String,
    photoURL: (json['photoURL'] as List<dynamic>?)?.cast<String>(),
    petIDs: (json['petIDs'] as List<dynamic>?)?.cast<String>(),
  );

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'name': name,
      'state': state,
      'city': city,
      'country': country,
      'coordinates': coordinates,
      'areaCode': areaCode,
      'phoneNumber': phoneNumber,
      'fullAddress': fullAddress,
      'surName': surName,
      'userName': userName,
      'email': email,
      'birthDate': birthDate.toIso8601String(),
      'about': about,
      'photoURL': photoURL,
      'petIDs': petIDs,
    };
  }

  factory Users.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;

    return Users(
      id: snapshot.id,
      name: data['name'] as String,
      state: data['state'] as String?,
      city: data['city'] as String,
      country: data['country'] as String?,
      coordinates: data['coordinates'] as GeoPoint?,
      areaCode: data['areaCode'] as String?,
      phoneNumber: data['phoneNumber'] as String?,
      fullAddress: data['fullAddress'] as String?,
      surName: data['surName'] as String,
      userName: data['userName'] as String,
      email: data['email'] as String,
      birthDate: DateTime.parse(data['birthDate'] as String),
      about: data['about'] as String,
      photoURL: (data['photoURL'] as List<dynamic>?)?.cast<String>(),
      petIDs: (data['petIDs'] as List<dynamic>?)?.cast<String>(),
    );
  }
}