import 'package:flutter/material.dart';
import 'package:untitled4/view/authentication/register_view.dart';
import '../../core/service/firebase_auth_service.dart';
import 'login_view.dart';

class BackgroundGradient extends StatelessWidget {
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
}
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
class CardWidget extends StatelessWidget {
  final Widget child;

  const CardWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: child,
      ),
    );
  }
}
class BottomButtons extends StatelessWidget {
  const BottomButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => SignupPage()));
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
              Auth().signInAnonymous();
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
            /*
            (ARDAHAN)   Alttaki kısım işine yararsa diye silmedim eğer lazım değilse sen silebilirsin
            validator: (value) {
              if (value!.isEmpty) {
                return 'Lütfen e-posta adresinizi girin';
              }
              return null;
            },
            */
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
class ForgotPasswordButton extends StatelessWidget {
  const ForgotPasswordButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () {
            // Şifremi unuttum işlemleri   (ARDAHAN)
          },
          child: TextButton(
            onPressed: () {
              forgotPassword(context);
            },
            child: const Text(
              'Şifremi unuttum?',
              style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'YA DA',
      style: TextStyle(
        fontSize: 16.0,
        color: Color(0xFFCE8BF8),
      ),
    );
  }
}
class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({super.key});

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
          // Google ile kaydol işlemleri    (ARDAHAN)
        },
        icon: Image.asset(
          'assets/google_logo.png',
          width: 35.0,
          height: 35.0,
        ),
        label: const Text(
          ' Google ile Giriş Yap ',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

