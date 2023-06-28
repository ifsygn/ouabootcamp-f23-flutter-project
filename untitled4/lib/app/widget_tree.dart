import 'package:flutter/cupertino.dart';
import '../core/service/firebase_auth_service.dart';
import '../view/intro/introduction_page.dart';
import 'home_page.dart';

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
          return IntroductionScreenWidget();
        }
      },
    );
  }
}