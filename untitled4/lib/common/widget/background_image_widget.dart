import 'package:flutter/cupertino.dart';

class BackgroundImageWidget extends StatelessWidget {
  final Widget child;

  const BackgroundImageWidget({required this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/arka.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: child,
    );
  }
}