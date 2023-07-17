import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(


      home: const IntroScreen2(title: ''),
    );
  }
}

class IntroScreen2 extends StatefulWidget {
  const IntroScreen2({super.key, required this.title});


  final String title;

  @override
  State<IntroScreen2> createState() => _IntroScreen2();
}

class _IntroScreen2 extends State<IntroScreen2> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(0),
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/intro2.png"),
              fit: BoxFit.cover),

        ),

        child: Column(

          children: <Widget>[
            SizedBox(height: 70,),

            Image.asset("images/logo.png",alignment: Alignment.topCenter,

            ),
            Padding(padding: EdgeInsets.all(30),
              child: Text("Hayvanlar hakkındaki tüm\n"
                  "   bilgileri cebinde taşı!",
                style: TextStyle(fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 28.0

                ),
              ),),

          ],
        ),

      ),


    );

  }
}