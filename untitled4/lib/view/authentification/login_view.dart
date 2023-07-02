import 'package:flutter/material.dart';
import '../../common/widget/background_gradient.dart';
import '../../common/widget/card_widget.dart';
import '../../common/widget/email_textfield.dart';
import '../../common/widget/forgotpassword_button.dart';
import '../../common/widget/login_button.dart';
import '../../common/widget/login_password_textfield_stful.dart';
import '../../common/widget/login_text.dart';
import '../../common/widget/image_widget.dart';
import '../../common/widget/ordivider_text.dart';
import '../../core/service/firebase_auth_service.dart';
import 'auth_viewmodel.dart';
import 'signup_view.dart';

void main() => runApp(const MyApp());

final _emailController = TextEditingController();
final _passwordController = TextEditingController();
final _confirmPasswordController = TextEditingController();
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoginView(),
    );
  }
}

bool isPasswordVisible = false;
class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          const BackgroundGradient(),
          const Positioned(
            top: 45.0,
            child: ImageWidget(
              imagePath: 'assets/paw_image.png',
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
          const Positioned(
            bottom: 15.0,
            child: BottomButtons(),
          ),
        ],
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
          const LoginText(),
          const SizedBox(height: 20.0),
          EmailTextField(controller: _emailController),
          const SizedBox(height: 8.0),
          PasswordTextField(controller: _passwordController),
          const ForgotPasswordButton(),
          const LoginButton(),
          const SizedBox(height: 8.0),
          const OrDivider(),
          const SizedBox(height: 8.0),
          const GoogleSignInButton(),
        ],
      ),
    );
  }
}

class BottomButtons extends StatelessWidget { //common.widget.XXX.dart
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
} //common.widget.XXX.dart

