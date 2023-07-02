import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

class UserView extends StatelessWidget {
  const UserView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
      ),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            const Positioned(
              top: 50,
              child: SizedBox(
                width: 150,
                height: 150,
                child: CircleAvatar(
                  backgroundImage: NetworkImage('[Image URL]'),
                ),
              ),
            ),
            const Positioned(
              top: 230,
              child: SizedBox(
                width: 280,
                height: 30,
                child: Text(
                  'John Doe',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff333333),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const Positioned(
              top: 271,
              child: SizedBox(
                width: 140,
                height: 24,
                child: Text(
                  'Software Engineer',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff333333),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const Positioned(
              top: 371,
              child: SizedBox(
                width: 176,
                height: 24,
                child: Text(
                  'John Doe',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff333333),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const Positioned(
              top: 420,
              child: SizedBox(
                width: 276,
                height: 80,
                child: Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed eu lobortis turpis, non consectetur eros. Fusce ultrices dolor et lacinia auctor.',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    height: 1.5,
                    color: Color(0xff666666),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Positioned(
              top: 545,
              child: SizedBox(
                width: 212,
                height: 44,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff7e07c9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    'Follow',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Color(0xffffffff),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}