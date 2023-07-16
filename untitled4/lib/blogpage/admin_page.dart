import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(


      home: const AdminPage(title: ''),
    );
  }
}

class AdminPage extends StatefulWidget {
  const AdminPage({super.key, required this.title});


  final String title;

  @override
  State<AdminPage> createState() => _AdminPageState();
}


class _AdminPageState extends State<AdminPage> {
  final myController = TextEditingController();
  @override
  void initState(){
    super.initState();

  }


  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }



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
                const SizedBox(
                  width: 450,
                  height: 420,
                  child:  DecoratedBox(
                    decoration:  BoxDecoration(
                        color: Colors.grey,

                    ),
                  ),
                ),
                IconButton(
                  onPressed: (){
                  },
                  padding: EdgeInsets.only(left: 100,top: 100),
                  icon: const Icon(
                    Icons.image,
                    size: 200,
                  ),
                ),

                IconButton(
                    onPressed: (){
                    },
                  padding: EdgeInsets.only(left: 280,top: 100),
                  icon: const Icon(
                    Icons.add,
                    size: 45,
                  ),
                  ),

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
                    child:IconButton(
                      onPressed: (){
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        size: 35,
                      ),
                    ),

                  ),
                ),

              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 50),
            child: Row(
              children: [
                 SizedBox(
                  width:300,
                 child: TextField(
                   controller: myController,
                  obscureText: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Başlık Ekleyin',
                  ),style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                ),
            ),
              ],
            ),
          ),

          SizedBox(
            height: 15,
          ),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 50),
            child: Row(
              children: [
                SizedBox(
                  width:300,
                  height: 270,
                  child: TextField(
                    controller: myController,
                    obscureText: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'İçerik Ekleyin',
                    ),
                    style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                    maxLines: 15, // <-- SEE HERE
                    minLines: 1,// <-- SEE HERE
                  ),
                ),
              ],
            ),
          ),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Text('Populer bloglara eklensin mi?'),
                SizedBox(
                  width: 20,
                ),
                ToggleSwitch(
                  initialLabelIndex: 0,
                  totalSwitches: 2,
                  labels: [
                    'Evet',
                    'Hayır',
                  ],
                  onToggle: (index) {
                    print('switched to: $index');
                  },
                ),
              ],
            ),),


        ],

      ),
    );




  }
}