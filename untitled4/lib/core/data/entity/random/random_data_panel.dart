import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled4/common/widget/appbarwidget.dart';
import 'package:untitled4/common/widget/nav_drawer.dart';
import 'package:untitled4/core/data/entity/random/random_data_api.dart';
import 'package:untitled4/core/data/repository/shelter_repository.dart';
import 'package:untitled4/core/data/repository/user_repository.dart';
import '../../../../common/helper/route/route_constant.dart';
import '../../../service/firebase_auth_service.dart';


UserRepository userRepository = UserRepository();
ShelterRepository shelterRepository = ShelterRepository();
User? user = Auth().currentUser;


class RandomDataPanel extends StatelessWidget {
  const RandomDataPanel({Key? key}) : super (key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: const NavDrawer(),
      body: const ButtonPanel(),
    );
  }
}

class ButtonPanel extends StatelessWidget {
  const ButtonPanel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ElevatedButton(
              onPressed:() async {
                // userRepository.addRandomData();
                RandomDataApi.getRandomUser();
              },
              child: const Text("Add Random User")),
          ElevatedButton(
              onPressed:() async {
                RandomDataApi.getRandomShelter();
              },
              child: const Text("Add Random Shelter")),
          ElevatedButton(
              onPressed:() async {
                RandomDataApi.getRandomPet();
              },
              child: const Text("Add Random Pet")),
          ElevatedButton(
              onPressed:() async {

              },
              child: const Text("Add Shelter from txt File")),
          ElevatedButton(
              onPressed:() async {
                Navigator.pushNamed(context, RouteConstant.shelterSearchRoute);
              },
              child: const  Text("Shelter Search Page")),
        ],
      ),
    );
  }
}
