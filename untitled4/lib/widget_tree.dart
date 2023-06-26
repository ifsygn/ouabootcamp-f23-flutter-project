import 'package:flutter/cupertino.dart';
import 'blogpage/home_page.dart';
import 'loginpage/model/auth.dart';
import 'loginpage/view_viewmodel/login_page/login_register_page.dart';

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
          return const LoginPage();
        }
      },
    );
  }
}