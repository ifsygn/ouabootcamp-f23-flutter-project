import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:untitled4/core/data/repository/pet_repository.dart';
import '../../common/widget/back_button_widget.dart';
import '../../common/widget/background_image_widget.dart';
import '../../common/widget/donate_widget.dart';
import '../../common/widget/shelter_address_widget.dart';
import '../../core/data/entity/pet.dart';
import '../../core/data/entity/shelter.dart';
import '../../core/data/repository/shelter_repository.dart';
import '../items/pet_item.dart';

final ShelterRepository shelterRepository = ShelterRepository();
final PetRepository petRepository = PetRepository();
List<Pet> petsOfShelter = [];


class ShelterProfilePage extends StatefulWidget {
  final Shelter shelter;

  const ShelterProfilePage({
    required this.shelter,
    Key? key,
  }) : super(key: key);


  @override
  _ShelterProfilePageState createState() => _ShelterProfilePageState(shelter);
}

class _ShelterProfilePageState extends State<ShelterProfilePage> {
  final Shelter shelter;
  late final List<Pet> petsOfShelter;
  _ShelterProfilePageState(this.shelter);

  int currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    // Veritabanından gerekli bilgileri çekmek için bir işlem yapabilirsiniz.
    // Değişkenleri güncelleyin.
    fetchAnimalData();
  }

  void fetchAnimalData() async {
    petsOfShelter = await petRepository.getPetsOfShelter(shelter) ?? [];
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundImageWidget(
        child: Column(
          children: [
            const BackButtonWidget(),
            Text(
              shelter.name ?? '',
              style: const TextStyle(fontSize: 24),
            ),
            CarouselSlider(
              options: CarouselOptions(
                height: 250,
                enableInfiniteScroll: false,
                viewportFraction: 1.0,
                enlargeCenterPage: true,
                onPageChanged: (index, _) {
                  setState(() {
                    currentPageIndex = index;
                  });
                },
              ),
              items: (shelter.photoURL ?? []).map((image) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Image.network(image, fit: BoxFit.cover),
                    );
                  },
                );
              }).toList(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List<Widget>.generate(shelter.photoURL!.length, (index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  width: 10.0,
                  height: 15.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: currentPageIndex == index ? Colors.white : Colors.grey,
                  ),
                );
              }),
            ),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.grey[400]?.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'Barınak Bilgisi',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          shelter.about ?? '',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: const DonateWidget(
                      iban: '''
                      Ziraat Bankası IBAN
                      
TR33 0000 0000 0000 0000 0000 00''',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ShelterAddressWidget(),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              child: const Text(
                'Hayvanlarımız',
                style: TextStyle(fontSize: 20),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Kedi butonuna basıldığında yapılacak işlemler
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF28F8F),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: const Text('Kedi'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {
                    // Köpek butonuna basıldığında yapılacak işlemler
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFCE8BF8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: const Text('Köpek'),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
/*                itemCount: petRefs.length,
                itemBuilder: (context, index) {
                  return PetItem(pet: petRefs[index]);
                }*/
                itemCount: petsOfShelter.length,
                itemBuilder: (context, index) {
                  return PetItem(pet: petsOfShelter[index]);
                }

                /*{
                  return PetItem(widget.animalImages[index]
                    image: widget.animalImages[index],
                    name: widget.animalNames[index],
                    years: widget.animalYears[index],
                  );
                },*/
              ),
            ),
          ],
        ),
      ),
    );
  }
}