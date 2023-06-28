import 'package:flutter/material.dart';
import '../../common/widget/background_gradient.dart';
import '../../common/widget/card_widget.dart';
import '../../common/widget/confirm_textfield.dart';
import '../../common/widget/email_textfield.dart';
import '../../common/widget/image_widget.dart';
import '../../common/widget/login_password_textfield_stful.dart';
import '../../common/widget/ordivider_text.dart';
import '../../common/widget/signup_button.dart';
import 'auth_viewmodel.dart';

void main() => runApp(const MyApp());
String confirmPassword = '';
String password = '';
final _emailController = TextEditingController();
final _passwordController = TextEditingController();
final _confirmPasswordController = TextEditingController();
String appImage='';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SignupPage(),
    );
  }
}

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
          const SignupButton(),
          const SizedBox(height: 8.0),
          const OrDivider(),
          const SizedBox(height: 8.0),
          const GoogleSignInButton(),
        ],
      ),
    );
  }
}



