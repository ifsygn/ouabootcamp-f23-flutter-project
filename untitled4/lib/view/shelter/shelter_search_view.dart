import 'package:flutter/material.dart';
import '../../common/widget/appbarwidget.dart';
import '../../common/widget/logowidget.dart';
import '../../common/widget/drawerpage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Barınaklar Uygulaması',
      home: BarinaklarView(),
    );
  }
}

class BarinaklarView extends StatelessWidget {
  const BarinaklarView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const appBarWidget(
        title: 'Barınaklar',
      ),
      drawer: const CustomDrawer(),
      body:
      Column(
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
            child: FutureBuilder<List<Barinak>>(
              future: fetchBarinaklarFromDatabase(),
              // Veritabanından barınakları çeken asenkron fonksiyon
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Image.network(snapshot.data![index].resimUrl),
                        title: Text(snapshot.data![index].ad),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  BarinakDetayView(
                                      barinak: snapshot.data![index]),
                            ),
                          );
                        },
                      );
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

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Drawer(
      child: NavDrawerWidget(),
    );
  }
}

class Barinak {
  final String ad;
  final String resimUrl;
  final String adres;

  Barinak({required this.ad, required this.resimUrl, required this.adres});
}

List<Barinak> barinaklar = [];

Future<List<Barinak>> fetchBarinaklarFromDatabase() async {
  // Burada veritabanından barınakları çeken bir işlem gerçekleştirilir.
  // Bu örnekte mock bir veritabanı kullanarak sabit verileri dönüyorum.
  await Future.delayed(const Duration(seconds: 3)); // Gerçek veritabanı isteğini simüle etmek için gecikme
  return barinaklar;
}

class BarinakDetayView extends StatelessWidget {
  final Barinak barinak;

  const BarinakDetayView({Key? key, required this.barinak}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(barinak.ad),
      ),
      body: Column(
        children: [
          Image.network(barinak.resimUrl),
          Text(barinak.adres),
          // Diğer ayrıntılar
        ],
      ),
    );
  }
}
