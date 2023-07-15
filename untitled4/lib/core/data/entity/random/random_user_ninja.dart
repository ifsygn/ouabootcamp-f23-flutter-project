import 'dart:convert';

import 'package:http/http.dart' as http;

class RandomUser {
  String id;
  String password;
  String email;
  String name;
  String phone;
  String gender;

  RandomUser({required this.id, required this.password, required this.email, required this.name, required this.phone, required this.gender});

  static Future<RandomUser> getRandomUser() async {
    var url = Uri.parse('https://api.api-ninjas.com/v1/randomuser');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      return RandomUser(
        id: json['id'],
        password: json['password'],
        email: json['email'],
        name: json['name']['first'] + ' ' + json['name']['last'],
        phone: json['phone'],
        gender: json['gender'],
      );
    } else {
      throw Exception('Failed to get random user');
    }
  }
}