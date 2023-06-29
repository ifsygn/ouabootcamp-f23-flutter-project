// Import the firebase_core and cloud_firestore plugin
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled4/core/data/entity/Pet.dart';

class PetRepository {

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Access the collection in the database using the collection's ID
  late final CollectionReference _petCollection = firestore.collection('Pet');
  // Access the document in the collection using the Pet's ID
  late final DocumentReference _petDocument = FirebaseFirestore.instance.collection('Pet').doc('Pet_id');




  Future<void> addPet({
    required String name,
    required String species,
    required String age,
  }) async {

    Map<String, dynamic> pet = <String, dynamic>{
      "name": name,
      "species": species,
      "age": age,
    };

    _petDocument.set(pet)
        .whenComplete(() => print("Pet ADDED to the database"))
        .catchError((e) => print(e));
  }

/*

  Future<void> addPet(String name, String city, String location) async {
    // Call the user's CollectionReference to add a new user

    return _PetCollection.add({
      'name': name,
      'city': city,
      'location': location
    })
        .then((value) => print("Pet Added"))
        .catchError((error) => print("Failed to add Pet: $error"));
  }
*/

  Future<void> addPetByJson(Pet pet) async {
    try {
      final newPet = await _petCollection.add(pet.toJson());
      print('Barınak başarıyla eklendi. ID: ${newPet.id}');
    } catch (e) {
      print('Barınak eklenirken bir hata oluştu: $e');
      // Hata durumunda gerekli işlemler yapılabilir, örneğin hata mesajını göstermek veya loglamak
    }
  }

  Future<void> deletePet({
    required String docId,
  }) async {

    await _petDocument.delete()
        .whenComplete(() => print('Pet DELETED from the database'))
        .catchError((e) => print(e));
  }

  Future<List<Pet>> getPets() async {
    // "PetCollection"dan sorgu atılır ve sonuç beklenir
    final querySnapshot = await _petCollection.get();

    // Belge listesi oluşturulur ve her belge için döngü yapılır
    final pets = querySnapshot.docs.map((doc) {
      // Belge verileri "data" değişkenine atanır
      final data = doc.data() as Map<String, dynamic>;

      // Veri alanları kontrol edilir ve null güvenliği sağlanır
      final name = data['name'] as String? ?? "";
      final species = data['species'] as String? ?? "";
      final age = data['phoneNumber'] as int? ?? 1;

      // Pet nesnesi oluşturulur
      final pet = Pet(
        petID: doc.id,
        name: name,
        species: species,
        age: age,
      );

      // Oluşturulan Pet nesnesi listeye eklenir
      return pet;
    }).toList();

    // Barınak listesi geri döndürülür
    return pets;
  }

  Future<List<Pet>> getPetsByCity(String city) async {
    final querySnapshot = await _petCollection.where('city', isEqualTo: city)
        .get();

    final pets = querySnapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;

      final name = data['name'] as String? ?? "";
      final species = data['species'] as String? ?? "";
      final age = data['age'] as int? ?? 1;

      final pet = Pet(
        petID: doc.id,
        name: name,
        species: species,
        age: age,
      );

      return pet;
    }).toList();

    return pets;
  }

  Future<Pet> getPetById(String id) async {
    try {
      final DocumentSnapshot snapshot = await _petCollection.doc(id).get();

      if (!snapshot.exists) {
        // Document does not exist
        throw Exception("Document does not exist");
      }

      // Retrieve the data from the snapshot
      final Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

      // Create a Pet object using the retrieved data
      final Pet pet = Pet(
        petID: data['id'] as String,
        species: data['species'] as String,
        age: data['age'] as int, name: '',
        // Add other properties accordingly
      );

      // Return the Pet object
      return pet;
    } catch (e) {
      // Handle any errors that occur during the process
      throw Exception("Something went wrong: $e");
    }
  }

  Future<List<Pet>> getPetsByName(String name) async {
    final querySnapshot = await _petCollection.where('name', isEqualTo: name)
        .get();

    final pets = querySnapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;

      final species = data['species'] as String? ?? "";
      final age = data['age'] as int? ?? 1;

      final pet = Pet(
        petID: doc.id,
        name: name,
        species: species,
        age: age,
      );

      return pet;
    }).toList();

    return pets;
  }

  Future<void> removePetById(String id) {
    return _petCollection
        .doc(id)
        .delete();
  }

  Future<QuerySnapshot> getPetCollection() {
    return _petCollection
        .get();
  }

/*  updatePet(Pet Pet) async {
    await PetCollection
        .doc(Pet.id)
        .update(Pet.toMap());
  }*/

  Future<void> updatePet(Pet pet) async {
    try {
      // Update the document with the new data from the Pet object
      await _petDocument.update(pet.toMap());

      // The update operation completed successfully
      print('Pet updated successfully');
    } catch (e) {
      // Handle any errors that occur during the update process
      throw Exception('Failed to update Pet: $e');
    }
  }

  Stream<QuerySnapshot> streamPetCollection() {
    return _petCollection
        .snapshots();
  }
}