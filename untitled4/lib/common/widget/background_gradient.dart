import 'package:flutter/cupertino.dart';

class BackgroundGradient extends StatelessWidget { //common.widget.XXX.dart
  const BackgroundGradient({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFCE8BF8), Color(0xFFF28F8F)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }
} //common.widget.XXX.dart