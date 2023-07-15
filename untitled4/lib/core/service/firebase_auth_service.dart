import 'package:cloud_firestore/cloud_firestore.dart';
import "package:firebase_auth/firebase_auth.dart";
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:untitled4/common/helper/route/route_constant.dart';
import 'package:untitled4/core/data/repository/user_repository.dart';

import '../data/entity/users.dart';


class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final CollectionReference _usersCollection = FirebaseFirestore.instance.collection('users');
  final UserRepository userRepository = UserRepository();

  User? get currentUser => _firebaseAuth.currentUser;
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signInWithEmailAndPassword({required String email,required String password,}) async {
    UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    String userID = userCredential.user?.uid ?? '';

    if(await userRepository.isDocumentExists(userID)) {
      //...
    } else {
      addUserByAuth(userID: userID, email: email, password: password);
    }
  }

  Future<void> createUserWithEmailAndPassword({required String email, required String password}) async {
    UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    String userID = userCredential.user?.uid ?? '';

    addUserByAuth(userID: userID, email: email, password: password);
  }

  Future<void> addUserByAuth({required String userID ,required String email, required String password}) async {

    Users user = Users(id: userID, email: email, password: password);

    _usersCollection.doc(userID)
        .withConverter<Users>(fromFirestore: (snapshot, _) => Users.fromJson(snapshot.data()!),
        toFirestore: (user, _) => user.toJson())
        .set(user)
        .onError((e, _) => print("Error writing document: $e"));

/*
    // Kullanıcının e-posta adresi, 'users' koleksiyonuna kaydedilir
    await _usersCollection
        .doc(userID)
        .set(user.toJson())
        .onError((e, _) => print("Error writing document: $e"));*/
}

  signInWithGoogle() async{
    final GoogleSignInAccount? googleUser= await GoogleSignIn(
      scopes: <String>["email"]).signIn();

    final GoogleSignInAuthentication googLeAuth = await googleUser!.authentication;

    final credential = GoogleAuthProvider.credential(
    accessToken: googLeAuth.accessToken,
    idToken: googLeAuth.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<void> verifyEmail ({required String email,required String password,}) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<void> signOut() async{
    await _firebaseAuth.signOut();
  }

  Future<void> signInAnonymous(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signInAnonymously();

      if (kDebugMode) {
        print("Signed in with temporary account.");
      }

      Navigator.pushNamed(context, RouteConstant.homePageRoute);

    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "operation-not-allowed":
          print("Anonymous auth hasn't been enabled for this project.");
          break;
        default:
          if (kDebugMode) {
            print("Unknown error.");
          }
      }
    }
  }
}