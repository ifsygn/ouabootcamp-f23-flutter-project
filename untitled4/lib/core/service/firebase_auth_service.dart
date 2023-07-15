import 'package:cloud_firestore/cloud_firestore.dart';
import "package:firebase_auth/firebase_auth.dart";
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:untitled4/common/helper/route/route_constant.dart';


class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final CollectionReference _userCollection = FirebaseFirestore.instance.collection('users');

  User? get currentUser => _firebaseAuth.currentUser;
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signInWithEmailAndPassword({required String email,required String password,}) async {
    await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> createUserWithEmailAndPassword({required String email,required String password,}) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);


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