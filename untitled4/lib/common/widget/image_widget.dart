import 'package:flutter/cupertino.dart';

class ImageWidget extends StatelessWidget {
  final String imagePath;
  final double width;
  final double height;

  const ImageWidget({super.key,
    required this.imagePath,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imagePath,
      width: width,
      height: height,
    );
  }
}