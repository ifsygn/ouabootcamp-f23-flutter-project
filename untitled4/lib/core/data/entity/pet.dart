import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled4/core/data/entity/shelter.dart';

//Data Model
class Pet {
  final String petID;
  String? ownerID; //Köpeğin sahip olunduğu yer.
  String? name;
  List<String>? species;
  String? folk;
  int? age;
  String? photoURL;
  String? info;

  Pet({
    required this.petID,
    this.ownerID,
    required this.name,
    required this.species,
    this.folk,
    required this.age,
    required this.photoURL,
    this.info,
  });

  Pet.fromJson(Map<String, Object?> json)
      : this(
    petID: json['petID']! as String,
    ownerID: json['ownerID'] as String,
    name: json['name']! as String,
    species: json['species'] as List<String>,
    folk: json['folk'] as String,
    age: json['age'] as int,
    photoURL: json['photoURL'] as String,
    info: json['info'] as String,
  );

  /*
    toJson():
    The toJson() does the opposite which is to map the data back into
    JSON format before we upload into Firebase.
    */

  Map<String, Object?> toJson() {
    return {
      "petID": petID,
      "ownerID": ownerID,
      "name": name,
      "species": species,
      "age": age,
      "photoURL": photoURL,
      "info": info,
    };
  }


  factory Pet.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;

    String petID = data?['petID'] as String;
    String ownerID = data?['ownerID'] as String;
    String name = data?['name'] as String;
    List<String> species = data?['species'] as List<String>;
    int age = data?['age'] as int;
    String photoURL = data?['photoURL'] as String;
    String info = data?['info'] as String;

    return Pet(
      petID: petID,
      ownerID: ownerID,
      name: name,
      species: species,
      age: age,
      photoURL: photoURL,
      info: info,
      );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'petID' : petID,
      'ownerID' : ownerID,
      'name': name,
      'species' : species,
      'age' : age,
      'photoURL' : photoURL,
      'info' : info,
    };
  }

  /*
    fromMap(Map snapshot, String id):
    When data is fetched from Firebase, it is in JSON format.
    this method allows us to map data from JSON format to our Product format.
    */
/*

  Pet.fromMap(Map snapshot,String id) :
        petID = id ?? '',
        name = snapshot['name'] ?? '',
        species = snapshot['species'] ?? '',
        age = snapshot['age'] ?? '';
*/


/*
  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "species": species,
      "age": age,
    };
  }

*/
  /*
  //contain data read from the document
  Pet.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : petID = doc.id,
        name = doc.data()!["name"],
        species = doc.data()!["species"],
        age = doc.data()!["age"];
  */
}