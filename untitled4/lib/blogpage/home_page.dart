import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../core/service/firebase_auth_service.dart';
import 'admin_page.dart';
import 'blog_first_page.dart';




class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super (key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  final User? user = Auth().currentUser;
  @override
  Widget build(BuildContext context) {
    if (user?.email == 'admin@admin.com') {
      return const AdminPage(title: "",);
    }
    else if(user!.isAnonymous){
      return const BlogAnaSayfa(title: "",);
    }
    else {
      return const BlogAnaSayfa(title: "",);
    }
  }
}