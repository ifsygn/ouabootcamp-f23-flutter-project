



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled4/core/data/entity/shelter.dart';

import '../entity/owner.dart';
import '../entity/pet.dart';

class PetRepository {


  FirebaseFirestore firestore = FirebaseFirestore.instance;

  /// Access the collection in the database using the collection's ID
  late final CollectionReference _shelterCollection = firestore.collection('shelters');
  /// Access the document in the collection using the shelter's ID
  // late final DocumentReference _shelterDocument = _shelterCollection.doc('shelter_id');

  /// A reference to the list of shelters.
  /// We are using `withConverter` to ensure that interactions with the collection
  /// are type-safe.
  final CollectionReference<Shelter> shelterRef = FirebaseFirestore.instance.collection('shelters')
      .withConverter<Shelter>(
    fromFirestore: (snapshot, _) => Shelter.fromJson(snapshot.data()!),
    toFirestore: (shelter, _) => shelter.toJson(),
  );

  /// Access the collection in the database using the collection's ID
  late final CollectionReference _petCollection = firestore.collection('pets');
  /// Access the document in the collection using the shelter's ID
  // late final DocumentReference _petDocument = _petCollection.doc('pet_id');

  /// A reference to the list of pets.
  /// We are using `withConverter` to ensure that interactions with the collection
  /// are type-safe.
  final petRef = FirebaseFirestore.instance.collection('pets')
      .withConverter<Pet>(
    fromFirestore: (snapshot, _) => Pet.fromJson(snapshot.data()!),
    toFirestore: (pet, _) => pet.toJson(),
  );


  /// Evcil hayvan belgesini ekleyen fonksiyon
  Future<void> addPetByNameAndUpdateShelter(String petName, String species, DocumentReference shelterRef) async {

    await _petCollection.add({
      'name': petName,
      'shelter': shelterRef,
      // Diğer evcil hayvan bilgileri
    });

    // Evcil hayvan belgesi eklenince, barınak belgesini güncelleyelim
    DocumentSnapshot shelterSnapshot = await shelterRef.get();
    List<DocumentReference> petRefs = (shelterSnapshot.data() as Map<String, dynamic>)['petRefs'] ?? [];
    petRefs.add(petRef as DocumentReference<Object?>);
    await shelterRef.update({'petRefs': petRefs});
  }

  /// add petID to shelter using shelterID
  Future<void> addPetToShelter(String petID, String shelterID) async {

    // Evcil hayvan belgesi eklenince, barınak belgesini güncelleyelim
    DocumentSnapshot shelterSnapshot = (await shelterRef.get()) as DocumentSnapshot<Object?>;
    List<DocumentReference> petRefs = (shelterSnapshot.data() as Map<String, dynamic>)['petRefs'] ?? [];
    petRefs.add(petRef as DocumentReference<Object?>);
    // await shelterRef.doc(id).update({'petRefs': petRefs});
    await shelterRef.doc(shelterID).get();
  }

  /// Bir barınaktaki evcil hayvanları sorgulayan fonksiyon
  Future<void> queryPetsInShelter(Shelter shelter) async {

    try {
      QuerySnapshot querySnapshot = await firestore
          .collection('pets')
          .where('shelter', isEqualTo: shelter)
          .get();

      for (var doc in querySnapshot.docs) {

        // Evcil hayvan bilgilerini alın
        Map<String, dynamic> petData = doc.data() as Map<String, dynamic>;

        print(petData['name']);
        // Diğer evcil hayvan bilgileri üzerinde işlemler yapabilirsiniz
      }
    } catch (e) {
      print('Evcil hayvanları sorgularken bir hata oluştu: $e');
    }
  }

  /// Bir evcil hayvanın bağlı olduğu barınağı almak için fonksiyon
  Future<Shelter?> getShelterOfPet(Pet pet) async {
    try {
      // Pet koleksiyonunda belirli bir peti al
      DocumentSnapshot petSnapshot = await _petCollection
          .doc(pet.petID)
          .get();

      // Petin sahibinin ownerID'sini al
      String? shelterID = (petSnapshot.data() as Map<String,
          dynamic>)['ownerID'];

      if (shelterID != null) {
        // Owner koleksiyonunda ownerID'ye göre sahibi al
        DocumentSnapshot ownerSnapshot = await _shelterCollection
            .doc(shelterID)
            .get();

        // Sahibi Owner nesnesine dönüştür
        Shelter shelter = Shelter.fromSnapshot(ownerSnapshot);
        return shelter;
      } else {
        return null; // OwnerID bulunamadıysa null döndür
      }
    } catch (e) {
      print('Hata: $e');
      return null; // Hata durumunda null döndür
    }
  }

  Future<Owner?> getOwnerOfPet(Pet pet) async {
    try {
      // Pet koleksiyonunda belirli bir peti al
      DocumentSnapshot petSnapshot = await _petCollection
          .doc(pet.petID)
          .get();

      // Petin sahibinin ownerID'sini al
      String? ownerID = (petSnapshot.data() as Map<String, dynamic>)['ownerID'];

      if (ownerID != null) {
        // Owner koleksiyonunda ownerID'ye göre sahibi al
        DocumentSnapshot ownerSnapshot = await FirebaseFirestore.instance
            .collection('owners')
            .doc(ownerID)
            .get();

        // Sahibi Owner nesnesine dönüştür
        Owner owner = Owner.fromSnapshot(ownerSnapshot);
        return owner;
      } else {
        return null; // OwnerID bulunamadıysa null döndür
      }
    } catch (e) {
      print('Hata: $e');
      return null; // Hata durumunda null döndür
    }
  }

  /// Bir evcil hayvanın bağlı olduğu barınağı almak için fonksiyon
  Future<String?> getOwnerIDOfPet(Pet pet) async {
    try {
      // Pet koleksiyonunda belirli bir peti al
      DocumentSnapshot petSnapshot = await FirebaseFirestore.instance
          .collection('pets')
          .doc(pet.petID)
          .get();

      // Petin sahibinin ownerID'sini al
      String? ownerID = (petSnapshot.data() as Map<String, dynamic>)['ownerID'];

      if (ownerID != null) {
        return ownerID;
      } else {
        return null; // OwnerID bulunamadıysa null döndür
      }
    } catch (e) {
      print('Hata: $e');
      return null; // Hata durumunda null döndür
    }
  }

  /// Bir evcil hayvanın bağlı olduğu barınağın datasını almak için fonksiyon
  Future<String?> getOwnerDataOfPet(Pet pet) async {
    try {
      var ownerID = getOwnerIDOfPet(pet) as String?;

      if (ownerID != null) {
        // Owner koleksiyonunda ownerID'ye göre sahibin verilerini al
        DocumentSnapshot ownerSnapshot = await FirebaseFirestore.instance
            .collection('owners')
            .doc(ownerID)
            .get();

        // Sahibin verilerini döndür
        return ownerSnapshot.data()?.toString();
      } else {
        return null; // OwnerID bulunamadıysa null döndür
      }
    } catch (e) {
      print('Hata: $e');
      return null; // Hata durumunda null döndür
    }
  }

  ///Shelter'daki evcil hayvan listesini al
  Future<List<Pet>> getPetsOfShelter(String shelterID) async {
      final querySnapshot = await _petCollection
          .where('ownerID', isEqualTo: shelterID)
          .get();

      final pets = querySnapshot.docs
          .map((doc) => Pet.fromSnapshot(doc))
          .toList();

      return pets;
  }
}