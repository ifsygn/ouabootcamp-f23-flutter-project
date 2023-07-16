import "package:firebase_auth/firebase_auth.dart";
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:untitled4/core/data/repository/user_repository.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
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
      userRepository.addUserByAuth(userID: userID, email: email, password: password);
    }
  }

  Future<void> createUserWithEmailAndPassword({required String email, required String password}) async {
    UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    String userID = userCredential.user?.uid ?? '';

    userRepository.addUserByAuth(userID: userID, email: email, password: password);
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

    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "operation-not-allowed":
          break;
        default:
          if (kDebugMode) {
            print("Unknown error.");
          }
      }
    }
  }
}