import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../view/authentication/login_view.dart';


class IntroductionScreenWidget extends StatelessWidget {
  final introKey = GlobalKey<IntroductionScreenState>();

  IntroductionScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      key: introKey,
      pages: [
        PageViewModel(
          title: "Sayfa 1",
          body: "Bu, tanıtım sayfasının açıklama metni.",
          image: Center(child: Lottie.network('https://assets5.lottiefiles.com/packages/lf20_il43ezyd.json', height: 250.0)),
        ),
        PageViewModel(
          title: "Sayfa 2",
          body: "Bu, tanıtım sayfasının açıklama metni.",
          image: Center(child: Image.asset('assets/introduction_screen/img_2.png', height: 200.0)),
        ),
        PageViewModel(
          title: "Sayfa 3",
          body: "Bu, tanıtım sayfasının açıklama metni.",
          image: Center(child: Image.asset('assets/introduction_screen/img_3.png', height: 200.0)),
        ),
        PageViewModel(
          title: "Sayfa 4",
          body: "Bu, tanıtım sayfasının açıklama metni.",
          image: Center(child: Image.asset('assets/introduction_screen/img_1.png', height: 200.0)),
        ),
      ],
      onDone: () {
        // Tanıtım sayfalarının tamamlandığı işlemleri buraya ekleyin
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const LoginView()),
        );
      },
      onSkip: () {
        // Tanıtım sayfalarının atlandığı işlemleri buraya ekleyin
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const LoginView()),
        );
      },
      showSkipButton: true,
      // skipFlex: 0,
      // nextFlex: 0,
      skip: const Text('Atla'),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Tamamla', style: TextStyle(fontWeight: FontWeight.w600)),
      dotsDecorator: DotsDecorator(
        size: const Size.square(10.0),
        activeSize: const Size(20.0, 10.0),
        activeColor: Colors.indigo,
        color: Colors.black26,
        spacing: const EdgeInsets.symmetric(horizontal: 3.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
    );
  }
}