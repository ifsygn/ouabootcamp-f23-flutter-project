import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';

import '../entity/pet.dart';
import '../entity/random/random_user.dart';
import '../entity/random/random_user_ninja.dart';
import '../entity/shelter.dart';
import '../entity/users.dart';

class UserRepository {


  FirebaseFirestore firestore = FirebaseFirestore.instance;

  /// Access the collection in the database using the collection's ID
  late final CollectionReference _usersCollection = firestore.collection('users');
  /// Access the document in the collection using the shelter's ID
  // late final DocumentReference _userDocument = _usersCollection.doc('user_id');

  /// A reference to the list of shelters.
  /// We are using `withConverter` to ensure that interactions with the collection
  /// are type-safe.
  final userRef = FirebaseFirestore.instance.collection('users')
      .withConverter<Users>(
    fromFirestore: (snapshot, _) => Users.fromJson(snapshot.data()!),
    toFirestore: (user, _) => user.toJson(),
  );

  /// A reference to the list of pets.
  /// We are using `withConverter` to ensure that interactions with the collection
  /// are type-safe.
  final petRef = FirebaseFirestore.instance.collection('pets')
      .withConverter<Pet>(
    fromFirestore: (snapshot, _) => Pet.fromJson(snapshot.data()!),
    toFirestore: (pet, _) => pet.toJson(),
  );


  ///Konum bilgilerini almak için aşağıdaki gibi bir fonksiyon oluşturabilirsiniz:
  Future<Position> getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Konum servislerinin etkin olup olmadığını kontrol edin
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Konum servisleri etkin değilse kullanıcıyı yönlendirin veya hata mesajı gösterin
      throw Exception('Konum servisleri etkin değil');
    }

    // Konum izni kontrolü yapın
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // İzin reddedilmişse, izin isteyin
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // İzin reddedilirse kullanıcıyı yönlendirin veya hata mesajı gösterin
        throw Exception('Konum izni reddedildi');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // İzin kalıcı olarak reddedildiyse kullanıcıyı yönlendirin veya hata mesajı gösterin
      throw Exception('Konum izni kalıcı olarak reddedildi');
    }

    // Konum bilgilerini alın
    return await Geolocator.getCurrentPosition();
  }

  Future<void> addUserToFirestore(Users user) async {
    try {
      await _usersCollection.doc(user.id).set(user.toJson());
      print('User added to Firestore successfully.');
    } catch (e) {
      print('Error adding user to Firestore: $e');
      throw Exception('Failed to add user to Firestore: $e');
    }
  }

  Future<bool> isDocumentExists(String documentId) async {

    final DocumentSnapshot snapshot = await _usersCollection
        .doc(documentId)
        .get();

    return snapshot.exists;
  }

  Future<void> addUserByAuth({required String userID ,required String email, required String password}) async {

    Users user = Users(id: userID, email: email, password: password);

    // Kullanıcının bilgileri, 'users' koleksiyonuna kaydedilir.
    _usersCollection.doc(userID)
        .withConverter<Users>(fromFirestore: (snapshot, _) => Users.fromJson(snapshot.data()!),
        toFirestore: (user, _) => user.toJson())
        .set(user)
        .onError((e, _) => print("Error writing document: $e"));
  }

  Future<void> addRandomUser() async {

      // Create a RandomUser object.
      var user = await RandomUser.getRandomUser();

      // Create a Users object from the RandomUser object.
      var users = Users(
        id: user.id,
        password: user.password,
        email: user.email,
        name: user.name,
        phoneNumber: user.phone,
      );

      // Get a JSON representation of the Users object.
      // var json = users.toJson();

      // Print the JSON representation of the Users object.
      // print(json);


    // Kullanıcının bilgileri, 'users' koleksiyonuna kaydedilir.
    _usersCollection.doc(user.id)
        .withConverter<Users>(fromFirestore: (snapshot, _) => Users.fromJson(snapshot.data()!),
        toFirestore: (users, _) => users.toJson())
        .set(users)
        .onError((e, _) => print("Error writing document: $e"));
  }
}