
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../view/authentication/login_view.dart';
import 'introscreen2.dart';
import 'introscreen1.dart';
import 'introscreen3.dart';





void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(


      home: const IntroductionScreenWidget(title: ''),
    );
  }
}

class IntroductionScreenWidget extends StatefulWidget {
  const IntroductionScreenWidget({super.key, required this.title});


  final String title;

  @override
  State<IntroductionScreenWidget> createState() => _IntroPage1();
}

class _IntroPage1 extends State<IntroductionScreenWidget> {
  PageController _controller= PageController();
  bool onLastPage=false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Stack(
        children:[
          PageView(
            controller: _controller,
            onPageChanged: (index){
              setState(() {
                onLastPage= (index==2);
              });
            },
            children: [
              IntroScreen1(title: ""),
              IntroScreen2(title: ""),
              IntroScreen3(title: ""),


            ],
          ),
          Container(
            alignment: Alignment(0,0.89),
            child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                    onTap:(){
                      _controller.jumpToPage(2);
                    },
                    child:Text("skip",style: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.bold),)
                ),
                SmoothPageIndicator(controller: _controller, count: 3),
                onLastPage
                    ?GestureDetector(
                    onTap:(){
                      Navigator.push(context,
                        MaterialPageRoute(builder: (context){
                          return LoginView();
                        },),);
                    },
                    child:Text("done",style: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.bold),)
                )
                    :GestureDetector(
                    onTap:(){
                      _controller.nextPage(duration: Duration(milliseconds: 500), curve: Curves.easeIn);
                    },
                    child:Text("next",style: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.bold),)
                ),
              ], ),
          ),
        ],
      ),
    );
  }
}