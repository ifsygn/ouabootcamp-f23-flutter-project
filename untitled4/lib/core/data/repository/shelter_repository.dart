import 'package:flutter/material.dart';

// Import the firebase_core and cloud_firestore plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:untitled4/core/data/entity/shelter.dart';

class ShelterRepository {

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Access the collection in the database using the collection's ID
  late final CollectionReference _shelterCollection = firestore.collection('shelter');
  // Access the document in the collection using the shelter's ID
  late final DocumentReference _shelterDocument = FirebaseFirestore.instance.collection('shelter').doc('shelter_id');




  Future<void> addShelter({
    required String name,
    required String city,
    required String location,
  }) async {

    Map<String, dynamic> shelter = <String, dynamic>{
      "name": name,
      "city": city,
      "location": location,
    };

    _shelterDocument.set(shelter)
    .whenComplete(() => print("Shelter ADDED to the database"))
    .catchError((e) => print(e));
  }

/*

  Future<void> addShelter(String name, String city, String location) async {
    // Call the user's CollectionReference to add a new user

    return _shelterCollection.add({
      'name': name,
      'city': city,
      'location': location
    })
        .then((value) => print("Shelter Added"))
        .catchError((error) => print("Failed to add Shelter: $error"));
  }
*/

  Future<void> addShelterByJson(Shelter shelter) async {
    try {
      final newShelter = await _shelterCollection.add(shelter.toJson());
      print('Barınak başarıyla eklendi. ID: ${newShelter.id}');
    } catch (e) {
      print('Barınak eklenirken bir hata oluştu: $e');
      // Hata durumunda gerekli işlemler yapılabilir, örneğin hata mesajını göstermek veya loglamak
    }
  }

  Future<void> deleteShelter({
    required String docId,
  }) async {

    await _shelterDocument.delete()
        .whenComplete(() => print('Shelter DELETED from the database'))
        .catchError((e) => print(e));
  }

  Future<List<Shelter>> getShelters() async {
    // "shelterCollection"dan sorgu atılır ve sonuç beklenir
    final querySnapshot = await _shelterCollection.get();

    // Belge listesi oluşturulur ve her belge için döngü yapılır
    final shelters = querySnapshot.docs.map((doc) {
      // Belge verileri "data" değişkenine atanır
      final data = doc.data() as Map<String, dynamic>;

      // Veri alanları kontrol edilir ve null güvenliği sağlanır
      final name = data['name'] as String? ?? "";
      final location = data['location'] as String? ?? "";
      final phoneNumber = data['phoneNumber'] as String? ?? "";
      final city = data['city'] as String? ?? "";
      final type = data['type'] as String? ?? "";

      // Shelter nesnesi oluşturulur
      final shelter = Shelter(
        shelterID: doc.id,
        name: name,
        location: location,
        phoneNumber: phoneNumber,
        city: city,
        type: type,
      );

      // Oluşturulan Shelter nesnesi listeye eklenir
      return shelter;
    }).toList();

    // Barınak listesi geri döndürülür
    return shelters;
  }

  Future<List<Shelter>> getSheltersByCity(String city) async {
    final querySnapshot = await _shelterCollection.where('city', isEqualTo: city)
        .get();

    final shelters = querySnapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;

      final name = data['name'] as String? ?? "";
      final location = data['location'] as String? ?? "";
      final phoneNumber = data['phoneNumber'] as String? ?? "";
      final type = data['type'] as String? ?? "";

      final shelter = Shelter(
        shelterID: doc.id,
        name: name!,
        location: location!,
        phoneNumber: phoneNumber!,
        city: city,
        type: type!,
      );

      return shelter;
    }).toList();

    return shelters;
  }

  Future<Shelter> getShelterById(String id) async {
    try {
      final DocumentSnapshot snapshot = await _shelterCollection.doc(id).get();

      if (!snapshot.exists) {
        // Document does not exist
        throw Exception("Document does not exist");
      }

      // Retrieve the data from the snapshot
      final Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

      // Create a Shelter object using the retrieved data
      final Shelter shelter = Shelter(
        shelterID: data['id'] as String,
        name: data['name'] as String,
        city: data['city'] as String,
        // Add other properties accordingly
      );

      // Return the Shelter object
      return shelter;
    } catch (e) {
      // Handle any errors that occur during the process
      throw Exception("Something went wrong: $e");
    }
  }

  Future<List<Shelter>> getSheltersByName(String name) async {
    final querySnapshot = await _shelterCollection.where('name', isEqualTo: name)
        .get();

    final shelters = querySnapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;

      final location = data['location'] as String? ?? "";
      final phoneNumber = data['phoneNumber'] as String? ?? "";
      final city = data['city'] as String? ?? "";
      final type = data['type'] as String? ?? "";

      final shelter = Shelter(
        shelterID: doc.id,
        name: name,
        location: location,
        phoneNumber: phoneNumber,
        city: city,
        type: type,
      );

      return shelter;
    }).toList();

    return shelters;
  }

  Future<void> removeShelterById(String id) {
    return _shelterCollection
        .doc(id)
        .delete();
  }

  Future<QuerySnapshot> getShelterCollection() {
    return _shelterCollection
        .get();
  }

/*  updateShelter(Shelter shelter) async {
    await shelterCollection
        .doc(shelter.id)
        .update(shelter.toMap());
  }*/

  Future<void> updateShelter(Shelter shelter) async {
    try {
      // Update the document with the new data from the Shelter object
      await _shelterDocument.update(shelter.toMap());

      // The update operation completed successfully
      print('Shelter updated successfully');
    } catch (e) {
      // Handle any errors that occur during the update process
      throw Exception('Failed to update shelter: $e');
    }
  }

  Stream<QuerySnapshot> streamShelterCollection() {
    return _shelterCollection
        .snapshots();
  }
}