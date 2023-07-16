import 'package:flutter/material.dart';
import 'package:untitled4/view/authentication/register_view.dart';
import '../../common/widget/image_widget.dart';
import '../../core/service/firebase_auth_service.dart';


//Login_ViewModel
class BottomButtons extends StatelessWidget {
  const BottomButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterView()));
            // Yeni sayfada işlem yapılacak (ARDAHAN)
          },
          child: const Text(
            'Üye ol',
            style: TextStyle(
              fontSize: 13.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            // Şifremi unuttum işlemleri  (ARDAHAN)
          },
          child: TextButton(
            onPressed: () {
              Auth().signInAnonymous(context);
            },
            child: const Text(
              'Üye olmadan devam et?',
              style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class PasswordTextField extends StatefulWidget {
  final TextEditingController controller;

  const PasswordTextField({Key? key, required this.controller}) : super(key: key);

  @override
  _PasswordTextFieldState createState() => _PasswordTextFieldState();
}
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
}

class GoogleSignInButton extends StatelessWidget {

  final String text;
  const GoogleSignInButton({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.0,
      height: 45.0,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: TextButton.icon(
        onPressed: () {
          Auth().signInWithGoogle();
        },
        icon: Image.asset(
          'assets/google_logo.png',
          width: 35.0,
          height: 35.0,
        ),
        label: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}


//Register_ViewModel

