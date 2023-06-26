import "package:firebase_auth/firebase_auth.dart";
import 'package:google_sign_in/google_sign_in.dart';
class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User? get currentUser => _firebaseAuth.currentUser;
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signInWithEmailAndPassaword({required String email,required String password,}) async {
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
  Future<void> signInAnonymous() async{
    try {
      final userCredential =  await FirebaseAuth.instance.signInAnonymously();
      print("Signed in with temporary account.");
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "operation-not-allowed":
          print("Anonymous auth hasn't been enabled for this project.");
          break;
        default:
          print("Unknown error.");
      }
    }
  }
}