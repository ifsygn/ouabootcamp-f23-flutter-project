import 'package:flutter/cupertino.dart';
import 'package:untitled4/core/service/firebase_auth_service.dart';
import 'package:untitled4/view/blog/home_page.dart';
import 'package:untitled4/view/intro/introduction_screen.dart';

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
          return const HomePage();
        } else {
          return const IntroductionScreenWidget(title: "",);
        }
      },
    );
  }
}