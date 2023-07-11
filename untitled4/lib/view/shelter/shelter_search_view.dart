import 'package:flutter/material.dart';
import 'package:untitled4/core/data/repository/shelter_repository.dart';
import '../../common/widget/appbarwidget.dart';
import '../../common/widget/logowidget.dart';
import '../../common/widget/drawerpage.dart';
import '../../core/data/entity/shelter.dart';
import '../items/shelter_item.dart';

final ShelterRepository shelterRepository = ShelterRepository();

Future<List<Shelter>> getShelters() async {
  // Burada veritabanından barınakları çeken bir işlem gerçekleştirilir.
  // Bu örnekte mock bir veritabanı kullanarak sabit verileri dönüyorum.

  await Future.delayed(const Duration(seconds: 1)); // Gerçek veritabanı isteğini simüle etmek için gecikme

  var shelters = shelterRepository.getShelters();

  return shelters;
}

class ShelterSearchView extends StatelessWidget {
  const ShelterSearchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const appBarWidget(
        title: 'Barınaklar',
      ),
      drawer: NavDrawer(),
      body: Column(
        children: [
          const Positioned(child: logoWidget(),),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              height: 40,
              width: MediaQuery
                  .of(context)
                  .size
                  .width * 0.7,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: const Row(
                children: [
                  SizedBox(width: 8.0),
                  Icon(Icons.search),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Barınak Arama',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Shelter>>(
              future: getShelters(),
              // Veritabanından barınakları çeken asenkron fonksiyon
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return ShelterItem(shelter: snapshot.data![index]);
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ShelterDetailView extends StatelessWidget {
  final Shelter shelter;

  const ShelterDetailView({Key? key, required this.shelter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(shelter.name ?? 'Barınak İsmi: Örnek Barınak'),
      ),
      body: Column(
        children: [
          Image.network(shelter.photoURL ?? 'https://picsum.photos/200'),
          Text(shelter.fullAddress ?? 'Adres: Hata'),
          // Diğer ayrıntılar
        ],
      ),
    );
  }
}