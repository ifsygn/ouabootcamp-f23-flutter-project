import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'core/service/firebase_options.dart';
import 'view/intro/animated_splash_screen.dart';

Future <void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  //Firebase initialization
  await Firebase.initializeApp(
    // options: DefaultFirebaseOptions.currentPlatform,
  );
  // FirebaseApp myApp = Firebase.app('MyApp');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super (key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const AnimatedSplashScreenWidget(),
    );
  }
}
