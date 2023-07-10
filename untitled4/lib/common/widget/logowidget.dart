import 'package:flutter/cupertino.dart';
import 'image_widget.dart';

class logoWidget extends StatelessWidget {
  const logoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const ImageWidget(
        imagePath: 'assets/paw_image.png',
        width: 95.0,
        height: 65.0,
    );
  }
}