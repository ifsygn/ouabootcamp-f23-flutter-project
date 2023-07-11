import 'package:cloud_firestore/cloud_firestore.dart';
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
  String? photoURL;
  String? areaCode;
  String? phoneNumber;
  // Pet [] pets;

  Shelter({
    required this.shelterID,
    required this.name,
    required this.city,
    this.coordinates,
    this.state,
    this.country,
    this.type,
    this.areaCode,
    this.phoneNumber,
    this.fullAddress,
    this.photoURL,
    this.iBAN,
  });

  Shelter.extended({
    required this.shelterID,
    required this.name,
    required this.city,
    this.country,
    this.state,
    this.coordinates,
    this.type,
    this.areaCode,
    this.phoneNumber,
    this.fullAddress,
    this.photoURL,
  });

  factory Shelter.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;

    String shelterID = data?['shelterID'] as String;
    String name = data?['name'] as String;
    String city = data?['city'] as String;
    String state = data?['state'] as String;
    String country = data?['country'] as String;
    String phoneNumber = data?['phoneNumber'] as String;
    String areaCode = data?['areaCode'] as String;
    String type = data?['type'] as String;
    String fullAddress = data?['fullAddress'] as String;
    String photoURL = data?['photoURL'] as String;
    String iBAN = data?['iBAN'] as String;
    GeoPoint coordinates = data?['coordinates'] as GeoPoint;

    return Shelter(
        shelterID: shelterID,
        name: name,
        city: city,
        coordinates: coordinates);
  }

  Map<String, dynamic> toFirestore() {
    return {
      'shelterID' : shelterID,
      'name': name,
      'city' : city,
      'state' : state,
      'country' : country,
      'phoneNumber' : phoneNumber,
      'areaCode' : areaCode,
      'type' : type,
      'fullAddress' : fullAddress,
      'photoURL' : photoURL,
      'coordinates': coordinates,
    };
  }

  /*
    fromMap(Map snapshot, String id):
    When data is fetched from Firebase, it is in JSON format.
    this method allows us to map data from JSON format to our Product format.
    */

  Shelter.fromMap(Map snapshot,String id) :
        shelterID = id,
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
    state: json['state'] as String,
    country: json['country'] as String,
    phoneNumber: json['phoneNumber'] as String,
    areaCode: json['areaCode'] as String,
    type: json['type'] as String,
    fullAddress: json['fullAddress'] as String,
    photoURL: json['photoURL'] as String,
    iBAN: json['iBAN'] as String,
    coordinates: json['location']! as GeoPoint,
  );

  /*
    toJson():
    The toJson() does the opposite which is to map the data back into
    JSON format before we upload into Firebase.
    */

  Map<String, Object?> toJson() {
    return {
      'id' : shelterID,
      'name': name,
      'city': city,
      'state': state,
      'country': country,
      'phoneNumber': phoneNumber,
      'areaCode': areaCode,
      'type': type,
      'fullAddress': fullAddress,
      'photoURL': photoURL,
      'iBAN': iBAN,
      'coordinates': coordinates,
    };
  }

  //contain data read from the document
  Shelter.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : shelterID = doc.id,
        name = doc.data()!["name"],
        city = doc.data()!["city"],
        coordinates = doc.data()!["location"];
}