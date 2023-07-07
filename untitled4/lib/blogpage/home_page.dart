import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../common/helper/route/route_constant.dart';
import '../core/service/firebase_auth_service.dart';


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
    return Text(user?.email ?? 'Anonymous');
    //return Text(user?.email !=null ? '$user?.email' : "anonymous");
  }

  Widget _signOutButton(BuildContext context) {
    return ElevatedButton(
        onPressed:() async {
          signOut();
          Navigator.pushNamed(context, RouteConstant.loginScreenRoute);
        },
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
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _userUid(),
            ElevatedButton(
                onPressed:() async {
                  Navigator.pushNamed(context, RouteConstant.shelterSearchPageRoute);
                },
                child: const Text("Shelter Search Page")),
            _signOutButton(context),
          ],
        ),
      ),
    );
  }
}
