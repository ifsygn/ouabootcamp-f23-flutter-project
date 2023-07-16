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


      home: const BlogDetailPage(title: ''),
    );
  }
}

class BlogDetailPage extends StatefulWidget {
  const BlogDetailPage({super.key, required this.title});


  final String title;

  @override
  State<BlogDetailPage> createState() => _BlogDetailPage();
}

class _BlogDetailPage extends State<BlogDetailPage> {
  final String baslik="Hayvan Sahiplenme";
  final String icerik="";
  final String resim="assets/resimler/dogperson.jpg";


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,





        body: Column(
          children: [
            SizedBox(
              height: 430,
              child: Stack(
                children: [
                  Image.asset(resim,
                  height: 430,
                  width: 420,
                  fit: BoxFit.cover),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 40,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(42),
                          topRight: Radius.circular(42),
                        ),
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: 50,
                        left: 10
                      ),
                      child: iconback(),

                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: EdgeInsets.only(
                          top: 400,
                          right: 20
                      ),
                      child: favoriteicon(),

                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 50),
              child: Row(
                children: [
                  blogbaslik(baslik: baslik),


                ],

              ),

            ),
            SizedBox(
              height: 15,
            ),

            new Expanded( flex: 1,

              child: new SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 25),
               child:new Text(icerik
                ,
            style: new TextStyle(
              color: Colors.black,
              fontSize: 16,

            ), ),),

            )

          ],

        ),
    );

    }
}

class iconback extends StatelessWidget {
  const iconback({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.arrow_back,
      size: 35,
    );
  }
}

class favoriteicon extends StatelessWidget {
  const favoriteicon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.favorite_outline,
      size: 35,
      color: Colors.red,
    );
  }
}

class blogbaslik extends StatelessWidget {
  const blogbaslik({
    super.key,
    required this.baslik,
  });

  final String baslik;

  @override
  Widget build(BuildContext context) {
    return Text(baslik,
    style: TextStyle(fontWeight: FontWeight.bold,
      fontSize: 32,

    ),);
  }
}