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
  String? location;
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
    this.location,
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
        name = snapshot['name'] ?? '',
        city = snapshot['city'] ?? '',
        location = snapshot['location'] ?? '';

    /*
    toJson():
    The toJson() does the opposite which is to map the data back into
    JSON format before we upload into Firebase.
    */

  toJson() {
    return {
      "name": name,
      "city": city,
      "location": location,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "city": city,
      "location": location,
    };
  }

  //contain data read from the document
  Shelter.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : shelterID = doc.id,
        name = doc.data()!["name"],
        city = doc.data()!["city"],
        location = doc.data()!["location"],
        address = Address.fromMap(doc.data()!["address"]);
}