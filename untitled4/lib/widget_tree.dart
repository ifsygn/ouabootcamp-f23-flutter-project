<<<<<<< HEAD
import 'package:untitled4/loginpage/model/auth.dart';

import 'package:untitled4/pages/home_page.dart';
import 'package:untitled4/loginpage/view_viewmodel/login_register_page.dart';
=======
import 'package:untitled4/auth.dart';

import 'package:untitled4/pages/home_page.dart';
import 'package:untitled4/pages/login_register_page.dart';
>>>>>>> 476d46dbb8984dcf7dc0bcbc2c1b84836c1f6924
import 'package:flutter/material.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({Key? key}) : super (key: key);

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return HomePage();
        } else {
<<<<<<< HEAD
          return  const LoginPage();
=======
          return const LoginPage();
>>>>>>> 476d46dbb8984dcf7dc0bcbc2c1b84836c1f6924
        }
      },
    );
  }
}
