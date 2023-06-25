import 'package:flutter/material.dart';
import '../auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super (key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  String? errorMessage = "";
  String? resetMessage="";
  bool isLogin = true;

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  Future<void> signInWithEmailAndPassaword() async {
    try {
      await Auth().signInWithEmailAndPassaword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
    }
    on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }
  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
    }
    on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Future<void> verifyEmail() async{
    try {
      await Auth().verifyEmail(
          email: _controllerEmail.text,
          password: _controllerPassword.text
      );
      const snackBar = SnackBar(
        content: Text('Password Reset Email Sent !'),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }


    on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }
  Widget _entryField(String title,TextEditingController controller,) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(labelText: title),
    );
  }
  Widget _errorMessage() {
    return Text(errorMessage == "" ? "" : "Humm ? $errorMessage");
  }
  Widget _submitButton() {
    return ElevatedButton(
      onPressed:
      isLogin ? signInWithEmailAndPassaword : createUserWithEmailAndPassword,
      child: Text(isLogin ? "Login" : ' Register'),
    );
  }
  Widget _loginOrRegisterButton() {
    return TextButton(onPressed: () {
      setState(() {
        isLogin = !isLogin;
      });
    }, child: Text(isLogin ? "Register instead" : "Login instead"),);
  }
  Widget _forgotPassword(){
    return TextButton(onPressed: (){
      verifyEmail();
    }, child: const Text("Forgot Password"));
  }

  Widget _googleIconClick() {
    return GestureDetector(
      onTap: () {
        Auth().signInWithGoogle();
      },
      child: const Image(width: 100, image: AssetImage("assets/google_logo.png"),),
    );
  }
  Widget _anonymousLoginIn(){
    return TextButton(
        onPressed: (){
          Auth().signInAnonymous();
        },
        child: const Text("Login Without Being A Member"));
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _entryField("email", _controllerEmail),
                  _entryField("password", _controllerPassword),
                  _errorMessage(),
                  _submitButton(),
                  _loginOrRegisterButton(),
                  _forgotPassword(),
                  _googleIconClick(),
                  _anonymousLoginIn(),
                ],
              ),
            ),
          ],

        ),
      ),
    );
  }
}