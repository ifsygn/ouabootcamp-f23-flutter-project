import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'image_widget.dart';

class PasswordTextField extends StatefulWidget {
  final TextEditingController controller;

  const PasswordTextField({Key? key, required this.controller}) : super(key: key);

  @override
  _PasswordTextFieldState createState() => _PasswordTextFieldState();
} //common.widget.XXX.dart

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Padding(
          padding: EdgeInsets.only(right: 8.0),
          child: ImageWidget(
            imagePath: 'assets/password_icon.png',
            width: 28.0,
            height: 28.0,
          ),
        ),
        Expanded(
          child: TextFormField(
            controller: widget.controller,
            decoration: InputDecoration(
              labelText: 'Şifre',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(1.0),
              ),
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    isPasswordVisible = !isPasswordVisible;
                  });
                },
                child: Icon(
                  isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                ),
              ),
            ),
            obscureText: !isPasswordVisible,
          ),
        ),
      ],
    );
  }
} //common.widget.XXX.dart
