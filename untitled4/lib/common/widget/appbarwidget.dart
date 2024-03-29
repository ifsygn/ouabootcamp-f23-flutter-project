import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget{
  final String title;
  const AppBarWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        backgroundColor: const Color(0xFFD59CF9),
      title: Text(title,
      style: const TextStyle(
        color: Colors.white,
      ),
    ),
      );
  }
   @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
