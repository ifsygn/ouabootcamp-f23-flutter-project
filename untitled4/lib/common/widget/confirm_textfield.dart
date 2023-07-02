import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../view/authentication/register_view.dart';
import 'image_widget.dart';

class ConfirmTextField extends StatefulWidget {
  final TextEditingController confirmController;

  const ConfirmTextField({Key? key, required this.confirmController}) : super(key: key);

  @override
  _ConfirmTextFieldState createState() => _ConfirmTextFieldState();
}
class _ConfirmTextFieldState extends State<ConfirmTextField> {
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
            onChanged: (value) {
              confirmPassword = value;
            },
            controller: widget.confirmController,
            decoration: InputDecoration(
              labelText: 'Şifre Onayla',
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
}