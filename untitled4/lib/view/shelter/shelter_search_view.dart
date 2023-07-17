import 'package:flutter/material.dart';
import 'package:untitled4/common/widget/drawer/my_navigation_drawer.dart';
import 'package:untitled4/core/data/repository/shelter_repository.dart';
import '../../common/widget/appbarwidget.dart';
import '../../common/widget/logowidget.dart';
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

class ShelterSearchPage extends StatelessWidget {
  const ShelterSearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: AppBarWidget(
        title: 'Barınaklar',
      ),
      drawer: MyNavigationDrawer(),
      body: ShelterSearchView(),
    );
  }
}

class ShelterSearchView extends StatelessWidget {
  const ShelterSearchView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const logoWidget(),
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
            child:  const Row(
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
        const  Expanded(
          child: MyShelterList(),
        ),
      ],
    );
  }
}

class MyShelterList extends StatefulWidget {
  const MyShelterList({super.key});

  @override
  State<MyShelterList> createState() => _MyShelterListState();
}

class _MyShelterListState extends State<MyShelterList> {
  late Future<List<Shelter>> _future;
  String searchText = '';

  @override
  void initState() {
    super.initState();
    _future = getShelters();
  }

  List<Shelter> filterBySearchText(List<Shelter> myModels, String searchText) {
    if (searchText.isEmpty) {
      return myModels;
    } else {
      return myModels
          .where((myModel) => myModel.name!.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Shelter>>(
      // Veritabanından barınakları çeken asenkron fonksiyon
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Hata: ${snapshot.error}'));
        } else {
          final myModels = snapshot.data!;
          final List<Shelter> filteredMyModels = filterBySearchText(myModels, searchText);
          return ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final shelterItem = filteredMyModels[index];
              return ShelterItem(shelter: shelterItem);
            },
          );
        }
      },
    );
  }

}

class ShelterList extends StatelessWidget {
  const ShelterList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Shelter>>(
      // Veritabanından barınakları çeken asenkron fonksiyon
      future: getShelters(),
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
          Image.network(shelter.photoURL?[0] ?? 'https://picsum.photos/200'),
          Text(shelter.fullAddress ?? 'Adres: Hata'),
          // Diğer ayrıntılar
        ],
      ),
    );
  }
}