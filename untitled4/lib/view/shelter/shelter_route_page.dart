import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:untitled4/blogpage/home_page.dart';
import 'package:untitled4/view/shelter/shelter_search_view.dart';
import '../../core/service/firebase_auth_service.dart';

class ShelterRoutePage extends StatefulWidget {
  const ShelterRoutePage({super.key});

  @override
  State<ShelterRoutePage> createState() => _ShelterRoutePageState();
}

class _ShelterRoutePageState extends State<ShelterRoutePage> {
  final User? user = Auth().currentUser;
  bool _showSnackBar = false;

  @override
  void initState() {
    super.initState();
    // Check if the user is anonymous and set the _showSnackBar variable accordingly.
    _showSnackBar = user?.isAnonymous ?? false;
    if (_showSnackBar) {
      // Schedule the snack bar to be shown after the current frame is built.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        copyToClipboard(context, "Anonim olarak sadece Bloglar görünür.");

        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => HomePage()));
      });
    }
  }

  void copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text)),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_showSnackBar) {
      // If _showSnackBar is true, show HomePage and then reset the _showSnackBar variable.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          _showSnackBar = false;
        });
      });
      return HomePage();
    } else {
      return const ShelterSearchPage();
    }
  }
}