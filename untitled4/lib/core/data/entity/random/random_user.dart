import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RandomUserAPI {
  final String firstName;
  final String lastName;
  final String email;

  RandomUserAPI({
    required this.firstName,
    required this.lastName,
    required this.email,
  });
}

class RandomApiScreen extends StatefulWidget {
  const RandomApiScreen({super.key});

  @override
  RandomApiScreenState createState() => RandomApiScreenState();
}

class RandomApiScreenState extends State<RandomApiScreen> {
  List<RandomUserAPI> users = [];

  Future<void> fetchRandomUsers() async {
    final response = await http.get(Uri.parse('https://randomapi.com/api/H0DG-RC4Y-43WZ-KJF2'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final results = jsonData['results'] as List<dynamic>;

      setState(() {
        users = results
            .map((user) => RandomUserAPI(
          firstName: user['first_name'],
          lastName: user['last_name'],
          email: user['email'],
        ))
            .toList();
      });
    } else {
      throw Exception('Failed to fetch users');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchRandomUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Random Users'),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return ListTile(
            title: Text('${user.firstName} ${user.lastName}'),
            subtitle: Text(user.email),
          );
        },
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: RandomApiScreen(),
  ));
}