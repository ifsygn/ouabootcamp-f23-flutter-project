import 'package:cloud_firestore/cloud_firestore.dart';

import 'owner.dart';

//Data Model
class Shelter extends Owner {
  final List<String>? type;
  final String? responsibleName;
  final String? iBAN;

  Shelter({
    required String id,
    required String? name,
    this.type,
    String? state,
    required String city,
    String? country,
    GeoPoint? coordinates,
    String? areaCode,
    String? phoneNumber,
    String? fullAddress,
    this.responsibleName,
    this.iBAN,
    String? about,
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

  Shelter.fromJson(Map<String, Object?> json)
      : this(
    id: json['id']! as String,
    name: json['name']! as String,
    type: json['type'] as List<String>,
    state: json['state'] as String,
    city: json['city']! as String,
    country: json['country'] as String,
    coordinates: json['coordinates']! as GeoPoint,
    areaCode: json['areaCode'] as String,
    phoneNumber: json['phoneNumber'] as String,
    fullAddress: json['fullAddress'] as String,
    responsibleName: json['responsibleName'] as String,
    iBAN: json['iBAN'] as String,
    about: json['about'] as String,
    photoURL: json['photoURL'] as List<String>,
    petIDs: json['petIDs'] as List<String>,
  );

  /*
    toJson():
    The toJson() does the opposite which is to map the data back into
    JSON format before we upload into Firebase.
    */

  Map<String, Object?> toJson() {
    return {
      'id' : id,
      'name': name,
      'type': type,
      'state': state,
      'city': city,
      'country': country,
      'coordinates': coordinates,
      'areaCode': areaCode,
      'phoneNumber': phoneNumber,
      'fullAddress': fullAddress,
      'responsibleName': responsibleName,
      'iBAN': iBAN,
      'about': about,
      'photoURL': photoURL,
      'petIDs': petIDs,
    };
  }

  @override
  factory Shelter.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    String id = snapshot.id;
    String name = data['name'] as String;
    List<String>? type = data['type'] as List<String>;
    String? state = data['state'] as String;
    String? city = data['city'] as String;
    String? country = data['country'] as String;
    GeoPoint? coordinates = data['coordinates'] as GeoPoint;
    String? areaCode = data['areaCode'] as String;
    String? phoneNumber = data['phoneNumber'] as String;
    String? fullAddress = data['fullAddress'] as String;
    String? responsibleName = data['responsibleName'] as String;
    String? iBAN = data['iBAN'] as String;
    String? about = data['about'] as String;
    List<String>? photoURL = data['photoURL'] as List<String>;
    List<String>? petIDs = data['petIDs'] as List<String>;

    return Shelter(
      id: id,
      name: name,
      type: type,
      state: state,
      city: city,
      country: country,
      coordinates: coordinates,
      areaCode: areaCode,
      phoneNumber: phoneNumber,
      fullAddress: fullAddress,
      responsibleName: responsibleName,
      iBAN: iBAN,
      about: about,
      photoURL: photoURL,
      petIDs: petIDs,
    );
  }

/*
  factory Shelter.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;

    String id = data?['id'] as String;
    String name = data?['name'] as String;
    String city = data?['city'] as String;
    String state = data?['state'] as String;
    String country = data?['country'] as String;
    String phoneNumber = data?['phoneNumber'] as String;
    String areaCode = data?['areaCode'] as String;
    List<String> type = data?['type'] as List<String>;
    String fullAddress = data?['fullAddress'] as String;
    String responsibleName = data?['responsibleName'] as String;
    String photoURL = data?['photoURL'] as String;
    String iBAN = data?['iBAN'] as String;
    GeoPoint coordinates = data?['coordinates'] as GeoPoint;

    return Shelter(
        id: id,
        name: name,
        city: city,
        state: state,
        country: country,
        phoneNumber: phoneNumber,
        areaCode: areaCode,
        type: type,
        fullAddress: fullAddress,
        responsibleName: responsibleName,
        photoURL: photoURL,
        iBAN: iBAN,
        coordinates: coordinates);
  }

  Map<String, dynamic> toFirestore() {
    return {
      'id' : id,
      'name': name,
      'city' : city,
      'state' : state,
      'country' : country,
      'phoneNumber' : phoneNumber,
      'areaCode' : areaCode,
      'type' : type,
      'fullAddress' : fullAddress,
      'responsibleName' : responsibleName,
      'photoURL' : photoURL,
      'coordinates': coordinates,
    };
  }
  */


  /*
    fromMap(Map snapshot, String id):
    When data is fetched from Firebase, it is in JSON format.
    this method allows us to map data from JSON format to our Product format.
    */
/*

  Shelter.fromMap(Map snapshot,String id) :
        id = id,
        name = snapshot['name'] as String,
        city = snapshot['city'] as String,
        coordinates = snapshot['location'] as GeoPoint;
*/

/*
  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "city": city,
      "location": coordinates,
    };
  }
*/

  /*
  //contain data read from the document
  Shelter.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : id = doc.id,
        name = doc.data()!["name"],
        city = doc.data()!["city"],
        coordinates = doc.data()!["location"];
  */

}