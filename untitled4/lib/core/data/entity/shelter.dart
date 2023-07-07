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
    this.type,
    this.phoneNumber,
  });

  factory Shelter.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;

    String shelterID = data?['shelterID'] as String;
    String name = data?['name'] as String;
    String city = data?['city'] as String;
    GeoPoint coordinates = data?['coordinates'] as GeoPoint;

    return Shelter(shelterID: shelterID, name: name, city: city, coordinates: coordinates);
  }

  Map<String, dynamic> toFirestore() {
    return {
      'shelterID' : shelterID,
      'name': name,
      'city' : city,
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
        coordinates = doc.data()!["location"];
}