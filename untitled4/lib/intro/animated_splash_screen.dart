import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:untitled4/widget_tree.dart';
import 'package:page_transition/page_transition.dart';

class AnimatedSplashScreenWidget extends StatelessWidget {
  const AnimatedSplashScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen( //https://pub.dev/packages/animated_splash_screen
      splash: Lottie.network('https://assets5.lottiefiles.com/packages/lf20_il43ezyd.json'),
      //Lottie.file(File('assets/gif/astronaut-cat.gif')),
      
      /*Column(
          children: [
            Image.asset('assets/splash_screen/paw_icon.png'),
            const Text('Sokakta Bir Arkadaş: SOBA app',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            )
          ]
      ),*/

      splashIconSize: 400,
      duration: 2000,
      backgroundColor: Colors.white,
      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.topToBottom,
      animationDuration: const Duration(seconds: 2),
      nextScreen: const WidgetTree(),
    );
  }
}
//icon image splash screen
/*
AnimatedSplashScreen( //https://pub.dev/packages/animated_splash_screen
      splash: Column(
        children: [
          Image.asset('assets/splash_screen/paw_icon.png'),
          const Text('Sokakta Bir Arkadaş: SOBA app',
              style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          )
        ]
      ),
      splashIconSize: 250,
      duration: 2000,
      backgroundColor: Colors.purpleAccent,
      splashTransition: SplashTransition.slideTransition,
      pageTransitionType: PageTransitionType.topToBottom,
      animationDuration: const Duration(seconds: 1),
      nextScreen: const WidgetTree(),
    );
 */

//animation image splash screen
/*

 */