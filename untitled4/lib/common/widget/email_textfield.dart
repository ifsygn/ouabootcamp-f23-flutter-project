import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../view/authentication/register_view.dart';
import 'image_widget.dart';

class EmailTextField extends StatelessWidget {
  final TextEditingController controller;

  const EmailTextField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Padding(
          padding: EdgeInsets.only(right: 2.0),
          child: ImageWidget(
            imagePath: 'assets/email_icon.png',
            width: 35.0,
            height: 35.0,
          ),
        ),
        Expanded(
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              labelText: 'E-posta',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(1.0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
