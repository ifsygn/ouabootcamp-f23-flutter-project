import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../model/auth.dart';



class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SignupPage(),
    );
  }
}


String confirmPassword = '';
String password = '';
String appImage='';

final _emailController = TextEditingController();
final _passwordController = TextEditingController();
final _confirmPasswordController = TextEditingController();

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    appImage="assets/paw_image.png";
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          const BackgroundGradient(),
           Positioned(
            top: 45.0,
            child: ImageWidget(
              imagePath: appImage,
              width: 95.0,
              height: 65.0,
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: CardWidget(
                  child: LoginForm(),
                ),
              ),
            ),
          ),
          Positioned(
            top: 25,
            left: 5,
            child: IconButton(
              padding: const EdgeInsets.all(18),
              alignment: Alignment.centerLeft,
              tooltip: 'Go back',
              enableFeedback: true,
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
    );
  }
}
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
class LoginForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Text(
            'ÜYE OLMA GİRİŞİ',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 20.0),
          EmailTextField(controller: _emailController),
          const SizedBox(height: 8.0),
          PasswordTextField(controller: _passwordController),
          const SizedBox(height: 8.0),
          ConfirmTextField(confirmController: _confirmPasswordController),
          const SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {
              if (password == confirmPassword) {
                createUserWithEmailAndPassword(context);
                Navigator.of(context).pop();
              }
              else{
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: const Text('Şifre doğrulanamadı.'),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('Tamam'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFCE8BF8)),
            child: Container(
              width: 170.0,
              height: 45.0,
              alignment: Alignment.center,
              child: const Text('Üye Ol', style: TextStyle(fontSize: 20.0, color: Colors.white)),
            ),
          ),
          const SizedBox(height: 8.0),
          const OrDivider(),
          const SizedBox(height: 8.0),
          const GoogleSignInButton(),
        ],
      ),
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
            onChanged: (value ) {
              password = value;
            },
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
        },
        icon: Image.asset(
          'assets/google_logo.png',
          width: 35.0,
          height: 35.0,
        ),
        label: const Text(
          ' Google ile Üye Ol ',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
Future<void> createUserWithEmailAndPassword(BuildContext context) async {
  try {
    await Auth().createUserWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    );
  }
  on FirebaseAuthException catch (e) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(e.message.toString()),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}