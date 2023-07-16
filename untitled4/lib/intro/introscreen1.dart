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


      home: const IntroScreen1(title: ''),
    );
  }
}

class IntroScreen1 extends StatefulWidget {
  const IntroScreen1({super.key, required this.title});


  final String title;

  @override
  State<IntroScreen1> createState() => _IntroScreen1();
}

class _IntroScreen1 extends State<IntroScreen1> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(0),
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/intro1.png"),
              fit: BoxFit.cover),

        ),

        child: Column(

          children: <Widget>[
            SizedBox(height: 70,),

            Image.asset("images/logo.png",alignment: Alignment.topCenter,

            ),
            Padding(padding: EdgeInsets.all(30),
              child: Text("Bir dost mu arıyorsun,\n"
                  "    hayvan sahiplen!",
                style: TextStyle(fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 30.0

                ),
              ),),

          ],
        ),

      ),


    );

  }
}