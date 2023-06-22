import 'package:firebase_auth/firebase_auth.dart';
<<<<<<< HEAD
import 'package:untitled4/loginpage/model/auth.dart';
=======
import 'package:untitled4/auth.dart';
>>>>>>> 476d46dbb8984dcf7dc0bcbc2c1b84836c1f6924
import 'package:flutter/material.dart';


class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super (key: key);

  final User? user = Auth().currentUser;

  Future<void> signOut() async {
    await Auth().signOut();
  }

  Widget _title() {
    return const Text("Firebase Auth");
  }

  Widget _userUid() {
<<<<<<< HEAD
    return Text(user?.email !=null ? '$user?.email' : "anonymous");
=======
    return Text(user?.email !=null ? 'User email' : "anonymous");
>>>>>>> 476d46dbb8984dcf7dc0bcbc2c1b84836c1f6924
  }

  Widget _signOutButton() {
    return ElevatedButton(
        onPressed: signOut,
        child: const Text("Sign Out")
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _title(),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
<<<<<<< HEAD
        padding: const EdgeInsets.all(20),
=======
        padding: EdgeInsets.all(20),
>>>>>>> 476d46dbb8984dcf7dc0bcbc2c1b84836c1f6924
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _userUid(),
            _signOutButton(),
          ],
        ),
      ),
    );
  }
}