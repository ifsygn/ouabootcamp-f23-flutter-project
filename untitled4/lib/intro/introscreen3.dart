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


      home: const IntroScreen3(title: ''),
    );
  }
}

class IntroScreen3 extends StatefulWidget {
  const IntroScreen3({super.key, required this.title});


  final String title;

  @override
  State<IntroScreen3> createState() => _IntroScreen3();
}

class _IntroScreen3 extends State<IntroScreen3> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(0),
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/intro3.png"),
              fit: BoxFit.cover),

        ),

        child: Column(

          children: <Widget>[
            SizedBox(height: 50,),

            Image.asset("images/logo.png",alignment: Alignment.topCenter,

            ),
            Padding(padding: EdgeInsets.all(20),
              child: Text("Bu uygulamada aynı anda\n"
                  "  barınakları ve hayvan \n"
                  "      dostlarımızı gör!",
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