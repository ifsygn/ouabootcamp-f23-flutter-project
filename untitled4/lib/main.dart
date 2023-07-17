import 'package:flutter/material.dart';
import 'package:untitled4/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:untitled4/view/intro/animated_splash_screen.dart';
import 'common/helper/route/route_generator.dart';

Future <void> main() async{
  WidgetsFlutterBinding.ensureInitialized();

  //Firebase initialization
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super (key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouterGenerator.generateRoute,
      home: const AnimatedSplashScreenWidget(),
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
    );
  }
}
