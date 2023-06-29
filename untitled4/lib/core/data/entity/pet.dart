import 'package:cloud_firestore/cloud_firestore.dart';

class Pet {
  final String petID;
  String? name;
  String? species;
  int? age;
  String? ownerID; //Köpeğin sahip olunduğu yer.

  Pet({
    required this.petID,
    required this.name,
    required this.species,
    required this.age
  });


  /*
    fromMap(Map snapshot, String id):
    When data is fetched from Firebase, it is in JSON format.
    this method allows us to map data from JSON format to our Product format.
    */

  Pet.fromMap(Map snapshot,String id) :
        petID = id ?? '',
        name = snapshot['name'] ?? '',
        species = snapshot['species'] ?? '',
        age = snapshot['age'] ?? '';

  /*
    toJson():
    The toJson() does the opposite which is to map the data back into
    JSON format before we upload into Firebase.
    */

  toJson() {
    return {
      "name": name,
      "species": species,
      "age": age,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "species": species,
      "age": age,
    };
  }

  //contain data read from the document
  Pet.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : petID = doc.id,
        name = doc.data()!["name"],
        species = doc.data()!["species"],
        age = doc.data()!["age"];
}