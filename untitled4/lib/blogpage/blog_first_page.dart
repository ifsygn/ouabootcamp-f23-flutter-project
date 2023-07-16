import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(


      home: const BlogAnaSayfa(title: ''),
    );
  }
}

class BlogAnaSayfa extends StatefulWidget {
  const BlogAnaSayfa({super.key, required this.title});


  final String title;

  @override
  State<BlogAnaSayfa> createState() => _BlogAnaSayfa();
}

class _BlogAnaSayfa extends State<BlogAnaSayfa> {

  @override
  Widget build(BuildContext context) {
    List<String> populer= [
      "dogperson.jpg",

      "back.jpg",
      "çocuk.jpg",
    ];
    List<String> populername= [
      "Hayvan ile Yaşam",
      "Kedi Bakımı",
      "köpek ile Çocuklar",

    ];
    List<String> son= [
      "dogperson.jpg",
      "dogperson.jpg",
      "dogperson.jpg",
      "dogperson.jpg",
    ];
    List<String> sonname= [
      "hayvan sahiplenme",
      "köpek bakımı",
      "kedi bakımı",
      "kedi",

    ];

    return Scaffold(

      body: arkaplan(populer: populer, populername: populername),
      bottomNavigationBar: GNav(
        backgroundColor: Colors.white,
        color: Color(0xFFBFBFBF),
        activeColor: Color(0xFFBA68C8),
        tabBackgroundColor: Colors.black12,
        gap: 8,
          tabs:const[
            GButton(icon: Icons.home,
            text: 'home',),
            GButton(icon: Icons.pets,
              text: 'blog',),
            GButton(icon: Icons.favorite,
              text: 'favorite',),
            GButton(icon: Icons.person,
              text: 'profile',),
          ]
      ),

    );

  }
}

class arkaplan extends StatelessWidget {
  const arkaplan({
    super.key,
    required this.populer,
    required this.populername,
  });

  final List<String> populer;
  final List<String> populername;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(0),
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/resimler/back.jpg"),
            fit: BoxFit.cover),

      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[

          const SizedBox(
            height: 70,
          ),
          Padding(padding: EdgeInsets.all(30),
           child: aramacubuk(),

          ),
          bosluk(),
          TextPopuler(),
          bosluk(),
          bloglist(populer: populer, populername: populername),
          bosluk(),
          TextSonEklenen(),
          bosluk(),
          bloglist(populer: populer, populername: populername),



        ],
      ),
    );
  }
}

class bosluk extends StatelessWidget {
  const bosluk({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 20,
    );
  }
}

class TextSonEklenen extends StatelessWidget {
  const TextSonEklenen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 25,
      width: 256,
      child:Text('Son Eklenen Bloglar',textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 22.0
        ) ,
      ),
    );
  }
}

class TextPopuler extends StatelessWidget {
  const TextPopuler({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 25,
      width: 215,
      child:Text('Popüler Bloglar',textAlign: TextAlign.center,
      style: TextStyle(fontWeight: FontWeight.bold,
        color: Colors.black,
        fontSize: 22.0
      ) ,
    ),
    );
  }
}

class bloglist extends StatelessWidget {
  const bloglist({
    super.key,
    required this.populer,
    required this.populername,
  });

  final List<String> populer;
  final List<String> populername;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 222,
      child: ListView.builder(
        itemCount: populer.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index){
          return Container(
            height: 222,
            width: 159,
            margin: EdgeInsets.only(
              left: index == 0 ? 30 : 15,
              right: index == 5 -1 ? 30 : 0,
            ),
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 3,
                  blurRadius: 4,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Column(children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset('assets/resimler/${populer[index]}',
                  width: 140,
                  height: 160, ),



              ),
              SizedBox(
                height: 2,
              ),

              favoriicon(),
              Row(
                children: [
                   Text(
                    populername[index],
                     style: TextStyle(
                     color: Colors.black,
                     fontSize: 16.0
                  ),

                   ),
              ], ),
            ],
            ),
          );
        }
      )
    );
  }
}

class favoriicon extends StatelessWidget {
  const favoriicon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
       const Icon(
          Icons.favorite_outline,
          color: Color(0xFFDD2A40),
          size: 18
       ),
      ],
    );
  }
}

class aramacubuk extends StatelessWidget {
  const aramacubuk({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 15),
        border: OutlineInputBorder(
         borderRadius: BorderRadius.circular(30),
         borderSide: BorderSide(width: 0.8),

     ),
       hintText: 'Blog Ara',

       prefixIcon: Icon(Icons.search, size: 30),
       suffixIcon: IconButton(icon: Icon(Icons.clear),
       onPressed: () {},
     ),
     ),
            );
  }
}
