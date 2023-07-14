import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled4/core/data/entity/owner.dart';

class Users extends Owner {
  final String surName;
  final String userName;
  final String email;
  final DateTime birthDate;
  final String url;

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
    required this.url,
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
}