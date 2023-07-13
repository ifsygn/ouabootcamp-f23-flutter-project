// Import the firebase_core and cloud_firestore plugin
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:untitled4/core/data/entity/shelter.dart';

class ShelterRepository {

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Access the collection in the database using the collection's ID
  late final CollectionReference _shelterCollection = firestore.collection('shelters');
  // Access the document in the collection using the shelter's ID
  late final DocumentReference _shelterDocument = FirebaseFirestore.instance
      .collection('shelters')
      .doc('shelter_id');

  /// A reference to the list of shelters.
  /// We are using `withConverter` to ensure that interactions with the collection
  /// are type-safe.
  final shelterRef = FirebaseFirestore.instance.collection('shelters')
      .withConverter<Shelter>(
    fromFirestore: (snapshot, _) => Shelter.fromJson(snapshot.data()!),
    toFirestore: (shelter, _) => shelter.toJson(),
  );

/*

  Future<void> addShelter({
    required String name,
    required String city,
    required GeoPoint coordinates,
  }) async {

    Map<String, dynamic> shelter = <String, dynamic>{
      "name": name,
      "city": city,
      "coordinates": coordinates,
    };

    _shelterDocument.set(shelter)
        .whenComplete(() => print("Shelter ADDED to the database"))
        .catchError((e) => print(e));
  }
*/

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

  Future<void> addSheltersFromTextFile(String filePath) async {
    String fileData = await rootBundle.loadString(filePath);
    List<String> lines = fileData.split('\n');
    List<Map<String, dynamic>> shelters = [];

    String name = '';
    String fullAddress = '';
    String phoneNumber = '';

    for (int i = 0; i < lines.length; i++) {
      String line = lines[i].trim();

      if (line.isNotEmpty) {
        if (line.startsWith('name: ')) {
          name = line.substring(6);
        } else if (line.startsWith('fullAddress: ')) {
          fullAddress = line.substring(13);
        } else if (line.startsWith('phoneNumber: ')) {
          phoneNumber = line.substring(13);

          Map<String, dynamic> shelterData = {
            'name': name,
            'fullAddress': fullAddress,
            'phoneNumber': phoneNumber,
          };

          shelters.add(shelterData);

          // Reset variables for the next shelter
          name = '';
          fullAddress = '';
          phoneNumber = '';
        }
      }
    }

    shelters.forEach((shelter) async {
      await _shelterCollection.add(shelter);
    });
  }

  Future<void> addShelterByJson(Shelter shelter) async {
    try {
      await _shelterCollection.add(shelter.toJson());
    } catch (e) {
      // Hata durumunda gerekli işlemler yapılabilir, örneğin hata mesajını göstermek veya loglamak
    }
  }

  Future<void> addSheltersByJsonText(Map<String, Object?> shelterJson) async {
    try {
      await _shelterCollection.add(shelterJson);
    } catch (e) {
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

  ///Get Shelter Collection as a List from Firebase
  Future<List<Shelter>> getShelters() async {
    // "shelterCollection"dan sorgu atılır ve sonuç beklenir
    final querySnapshot = await _shelterCollection.get();

    // Belge listesi oluşturulur ve her belge için döngü yapılır
    final shelters = querySnapshot.docs.map((doc) {
      // Belge verileri "data" değişkenine atanır
      final data = doc.data() as Map<String, dynamic>;

      // Veri alanları kontrol edilir ve null güvenliği sağlanır
      final name = data['name'] as String? ?? "";
      final coordinates = data['coordinates'] as GeoPoint;
      final city = data['city'] as String? ?? "";
      final phoneNumber = data['phoneNumber'] as String? ?? "";
      final type = (data['type'] as List<dynamic>?)?.cast<String>() ?? [];
      final fullAddress = data['fullAddress'] as String? ?? "";
      final photoURL = data['photoURL'] as String? ?? "";

      // Shelter nesnesi oluşturulur
      final shelter = Shelter(
        shelterID: doc.id,
        name: name,
        city: city,
        coordinates: coordinates,
        type: type,
        phoneNumber: phoneNumber,
        fullAddress: fullAddress,
        photoURL: photoURL,
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
      final coordinates = data['coordinates'] as GeoPoint;
      final phoneNumber = data['phoneNumber'] as String? ?? "";
      final type = (data['type'] as List<dynamic>?)?.cast<String>() ?? [];

      final shelter = Shelter(
        shelterID: doc.id,
        name: name,
        coordinates: coordinates,
        phoneNumber: phoneNumber,
        city: city,
        type: type,
      );

      return shelter;
    }).toList();

    return shelters;
  }

  Future<QuerySnapshot> getShelterCollection() {
    return _shelterCollection
        .get();
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

      final coordinates = data['coordinates'] as GeoPoint;
      final phoneNumber = data['phoneNumber'] as String? ?? "";
      final city = data['city'] as String? ?? "";
      final type = (data['type'] as List<dynamic>?)?.cast<String>() ?? [];

      final shelter = Shelter(
        shelterID: doc.id,
        name: name,
        coordinates: coordinates,
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

enum ShelterQuery {
  city,
  likesAsc,
  likesDesc,
  distance,
  petHotel,
  shelter,
}

extension on Query<Shelter> {
  /// Create a firebase query from a [ShelterQuery]
  Query<Shelter> queryBy(ShelterQuery query) {
    switch (query) {
      case ShelterQuery.shelter:
        return where('type', arrayContainsAny: ['shelter']);

      case ShelterQuery.petHotel:
        return where('type', arrayContainsAny: ['petHotel']);

      case ShelterQuery.likesAsc:
      case ShelterQuery.likesDesc:
        return orderBy('likes', descending: query == ShelterQuery.likesDesc);

      case ShelterQuery.city:
        return orderBy('city', descending: false);

      case ShelterQuery.distance:
        return orderBy('distance', descending: false);
    }
  }
}