import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled4/core/data/entity/owner.dart';

class Users extends Owner {
  final String email;
  final String password;
  String? surName;
  String? userName;
  DateTime? birthDate;
  String? profilPhotoURL;

  Users({
    required String id,
    required this.email,
    required this.password,
    String? name = "",
    String? surName = "",
    String? userName = "",
    DateTime? birthDate,
    String? city = "",
    String? state = "",
    String? country = "",
    GeoPoint? coordinates = const GeoPoint(0.0, 0.0),
    String? areaCode = "",
    String? phoneNumber = "",
    String? fullAddress = "",
    String? about = "",
    List<String>? photoURL,
    String? profilPhotoURL,
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
    photoURL: photoURL ?? ["https://loremflickr.com/320/240/human,face/all"],
    petIDs: petIDs ?? ["1"],
  ) {
    // Set the default birthdate value at runtime if it's not provided
    this.birthDate = birthDate ?? DateTime(2023, 7, 18, 12, 00);
    this.profilPhotoURL = profilPhotoURL ?? "https://loremflickr.com/320/240/human,face/all";
  }

  Users.fromJson(Map<String, Object?> json)
      : this(
    id: json['id']! as String,
    email: json['email']! as String,
    password: json['password']! as String,
    name: json['name']! as String?,
    state: json['state'] as String?,
    city: json['city']! as String?,
    country: json['country'] as String?,
    coordinates: json['coordinates']! as GeoPoint?,
    areaCode: json['areaCode'] as String?,
    phoneNumber: json['phoneNumber'] as String?,
    fullAddress: json['fullAddress'] as String?,
    surName: json['surName'] as String?,
    userName: json['userName'] as String?,
    birthDate: DateTime.parse(json['birthDate']! as String),
    about: json['about']! as String?,
    photoURL: (json['photoURL'] as List<dynamic>?)?.cast<String>(),
    profilPhotoURL: json['photoURL'] as String?,
    petIDs: (json['petIDs'] as List<dynamic>?)?.cast<String>(),
  );

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'email': email,
      'password': password,
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
      'birthDate': birthDate?.toIso8601String(), // Convert to ISO8601 format
      'about': about,
      'photoURL': photoURL,
      'profilPhotoURL': profilPhotoURL,
      'petIDs': petIDs,
    };
  }

  factory Users.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;

    return Users(
      id: snapshot.id,
      email: data['email'] as String,
      password: data['password'] as String,
      name: data['name'] as String?,
      state: data['state'] as String?,
      city: data['city'] as String?,
      country: data['country'] as String?,
      coordinates: data['coordinates'] as GeoPoint?,
      areaCode: data['areaCode'] as String?,
      phoneNumber: data['phoneNumber'] as String?,
      fullAddress: data['fullAddress'] as String?,
      surName: data['surName'] as String?,
      userName: data['userName'] as String?,
      birthDate: data['birthDate'] != null ? DateTime.parse(data['birthDate'] as String) : null,
      about: data['about'] as String?,
      photoURL: (data['photoURL'] as List<dynamic>?)?.cast<String>(),
      profilPhotoURL: data['profilPhotoURL'] as String?,
      petIDs: (data['petIDs'] as List<dynamic>?)?.cast<String>(),
    );
  }
}