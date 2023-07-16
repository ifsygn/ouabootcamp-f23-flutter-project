// ignore_for_file: unnecessary_string_interpolations, avoid_unnecessary_containers, prefer_const_constructors

import 'package:flutter/material.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  String name = "";
  String summary = "";
  String city = "";
  String contact = "";
  String email = "";
  List<String> animalNames = [];
  List<String> animalImages = [];
  String profileImage = "";

  @override
  void initState() {
    super.initState();
    fetchUserDataFromDatabase();
    fetchAnimalDataFromDatabase();
    fetchprofileImageFromDatabase();
  }

  void fetchUserDataFromDatabase() {
    // Kullanıcı bilgilerini veritabanından çekme işlemleri burada gerçekleştirilir.
    // Bu örnekte sabit değerler kullanarak simüle ediyoruz.
    setState(() {
      name = "Aleyna Toprak";
      summary = "Bu alana özet bilgisi gelecektir.";
      city = "ANKARA";
      contact = "Aleyna TOPRAK";
      email = "aleyna.toprak5461@gmail.com";
    });
  }

  void fetchAnimalDataFromDatabase() {
    // Hayvan bilgilerini veritabanından çekme işlemleri burada gerçekleştirilir.
    // Bu örnekte sabit değerler kullanarak simüle ediyoruz.
    setState(() {
      animalNames = ["Kartopu", "Pamuk", "Pamuk", "Pamuk", "Kartopu"];
      /*animalImages = [
        "images/kedi.jpg",
        "images/kopek.jpg",
        "images/kopek.jpg",
        "images/kopek.jpg"
      ];*/

      animalImages = [
        'https://media.istockphoto.com/id/1361394182/tr/foto%C4%9Fraf/funny-british-shorthair-cat-portrait-looking-shocked-or-surprised.jpg?s=612x612&w=0&k=20&c=ES-dOavVWSDZ_ft64OjGDoiWHWKV7URNOpMZLEIAzYE=',
        'https://media.istockphoto.com/id/1361394182/tr/foto%C4%9Fraf/funny-british-shorthair-cat-portrait-looking-shocked-or-surprised.jpg?s=612x612&w=0&k=20&c=ES-dOavVWSDZ_ft64OjGDoiWHWKV7URNOpMZLEIAzYE=',
        'https://media.istockphoto.com/id/1361394182/tr/foto%C4%9Fraf/funny-british-shorthair-cat-portrait-looking-shocked-or-surprised.jpg?s=612x612&w=0&k=20&c=ES-dOavVWSDZ_ft64OjGDoiWHWKV7URNOpMZLEIAzYE=',
        'https://media.istockphoto.com/id/1361394182/tr/foto%C4%9Fraf/funny-british-shorthair-cat-portrait-looking-shocked-or-surprised.jpg?s=612x612&w=0&k=20&c=ES-dOavVWSDZ_ft64OjGDoiWHWKV7URNOpMZLEIAzYE=',
        'https://media.istockphoto.com/id/1361394182/tr/foto%C4%9Fraf/funny-british-shorthair-cat-portrait-looking-shocked-or-surprised.jpg?s=612x612&w=0&k=20&c=ES-dOavVWSDZ_ft64OjGDoiWHWKV7URNOpMZLEIAzYE='
      ];
    });
  }

  void fetchprofileImageFromDatabase() {
    // Profil arka planı resmini veritabanından çekme işlemi burada gerçekleştirilir.
    // Bu örnekte sabit bir değer kullanarak simüle ediyoruz.
    setState(() {
      profileImage =
      'https://images.pexels.com/photos/3307758/pexels-photo-3307758.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=250';
      //profileImage = 'images/profil.jpg';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.purple,
          ),
          onPressed: () {},
        ),
        actions: [
          Container(
            padding: const EdgeInsets.only(top: 10.0, right: 10.0),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(
                Icons.edit,
                color: Colors.purple,
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: Container(
        child: Container(
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/flat.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20.0),
                Center(
                  child: Stack(
                    children: [
                      Container(
                        width: 130,
                        height: 130,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 4,
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                          boxShadow: [
                            BoxShadow(
                              spreadRadius: 2,
                              blurRadius: 10,
                              color: Colors.black.withOpacity(0.1),
                              offset: const Offset(0, 10),
                            ),
                          ],
                          color: Colors.grey.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(30.0),
                          image: DecorationImage(
                            image: NetworkImage(profileImage),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Text(
                    '$name',
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50.0,
                  child: Divider(
                    height: 0,
                    thickness: 0,
                    color: Colors.transparent,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.10),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          '$summary',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'Yaşadığı Şehir: $city',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'İletişim: $contact',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'E-Posta: $email',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              'Benim Hayvanlarım',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () {},
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Column(
                        children: List<Widget>.generate(
                            (animalNames.length / 2).ceil(), (index) {
                          final startIndex = index * 2;
                          final endIndex = startIndex + 1;

                          return Row(
                            children: [
                              Expanded(
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Column(
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                        BorderRadius.circular(20.0),
                                        child: Image.network(
                                          animalImages[startIndex],
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Text(
                                        animalNames[startIndex],
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              if (endIndex < animalNames.length)
                                Expanded(
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0),
                                    ),
                                    child: Column(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                          BorderRadius.circular(20.0),
                                          child: Image.network(
                                            animalImages[endIndex],
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Text(
                                          animalNames[endIndex],
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                            ],
                          );
                        }),
                      ),
                      const SizedBox(height: 10.0),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: UserProfilePage(),
  ));
}
