import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ShelterPage(),
    );
  }
}

class BackgroundImageWidget extends StatelessWidget {
  final Widget child;

  const BackgroundImageWidget({required this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/arka.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: child,
    );
  }
}

class ShelterPage extends StatefulWidget {
  const ShelterPage({Key? key});

  @override
  _ShelterPageState createState() => _ShelterPageState();
}

class _ShelterPageState extends State<ShelterPage> {
  String shelterName = '';
  String shelterInfo = '';
  List<String> shelterImages = [];
  List<String> animalNames = [];
  List<String> animalYears = [];
  List<String> animalImages = [];

  @override
  void initState() {
    super.initState();
    // Veritabanından gerekli bilgileri çekmek için bir işlem yapabilirsiniz.
    // Değişkenleri güncelleyin.
    fetchAnimalData();
  }

  void fetchAnimalData() {
    // Animal verilerini veritabanından çekmek için uygun bir yöntem kullanın.
    // animalNames, animalYears ve animalImages değişkenlerini güncelleyin.
    // Örnek olarak, sabit veriler var aşağıda
    setState(() {
      animalNames = [];
      animalYears = [];
      animalImages = [
        /*
        'https://example.com/image1.jpg',
        'https://example.com/image2.jpg',
        'https://example.com/image3.jpg', */
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ShelterPageContent(
        shelterName: shelterName,
        shelterInfo: shelterInfo,
        shelterImages: shelterImages,
        animalNames: animalNames,
        animalYears: animalYears,
        animalImages: animalImages,
      ),
    );
  }
}

class ShelterPageContent extends StatefulWidget {
  final String shelterName;
  final String shelterInfo;
  final List<String> shelterImages;
  final List<String> animalNames;
  final List<String> animalYears;
  final List<String> animalImages;

  const ShelterPageContent({
    required this.shelterName,
    required this.shelterInfo,
    required this.shelterImages,
    required this.animalNames,
    required this.animalYears,
    required this.animalImages,
    Key? key,
  }) : super(key: key);

  @override
  _ShelterPageContentState createState() => _ShelterPageContentState();
}

class _ShelterPageContentState extends State<ShelterPageContent> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BackgroundImageWidget(
      child: Column(
        children: [
          const BackButtonWidget(),
          Text(
            widget.shelterName,
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
            items: widget.shelterImages.map((image) {
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
            children: List<Widget>.generate(widget.shelterImages.length, (index) {
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
                        widget.shelterInfo,
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
              itemCount: widget.animalNames.length,
              itemBuilder: (context, index) {
                return AnimalCard(
                  image: widget.animalImages[index],
                  name: widget.animalNames[index],
                  years: widget.animalYears[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, top: 16.0),
      child: Align(
        alignment: Alignment.topLeft,
        child: Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xFFD59CF9),
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              // Geri gelme iconuna basıldığında yapılacak işlemler
            },
          ),
        ),
      ),
    );
  }
}

class AnimalCard extends StatelessWidget {
  final String image;
  final String name;
  final String years;

  const AnimalCard({
    required this.image,
    required this.name,
    required this.years,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(image),
      title: Text(name),
      subtitle: Text(years),
    );
  }
}

class ShelterAddressWidget extends StatelessWidget {
  final String barinakAdresi =
      "Ankara Üniversitesi Veteriner Fakültesi Hayvan Hastanesi";
  final Uri mapsUrl = Uri.parse("https://www.google.com/maps/place/Ankara+%C3%9Cniversitesi+Veteriner+Fak%C3%BCltesi+Hayvan+Hastanesi/@39.9584876,32.8035677,13z/data=!4m10!1m2!2m1!1shayvan+hastanesi!3m6!1s0x14d34dd7a255b867:0x1fdaa407f88713dc!8m2!3d39.9584845!4d32.8636238!15sChBoYXl2YW4gaGFzdGFuZXNpWhIiEGhheXZhbiBoYXN0YW5lc2mSAQ9hbmltYWxfaG9zcGl0YWyaASRDaGREU1VoTk1HOW5TMFZKUTBGblNVTjRjRmszYlc5M1JSQULgAQA!16s%2Fg%2F11g71by0sw?entry=ttu");

  ShelterAddressWidget({super.key});

  void launchMapsUrl() async {
    if (!await launchUrl(mapsUrl)) {
      throw Exception('Could not launch $mapsUrl');
      //await launch(mapsUrl);
    } else {
      throw 'Yüklenemedi $mapsUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: launchMapsUrl,
      child: Row(
        children: [
          Image.asset(
            'assets/map.png',
            width: 85,
            height: 24,
          ),
          const Text(
            "Türkiye, Ankara",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}

class DonateWidget extends StatelessWidget {
  final String iban;

  const DonateWidget({Key? key, required this.iban, required TextStyle style}) : super(key: key);

  void _copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('IBAN panoya kopyalandı')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => _copyToClipboard(context, iban),
          child: Image.asset(
            'assets/donate.png',
            width: 35,
            height: 35,
          ),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () => _copyToClipboard(context, iban),
          child: Text(
            iban,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 8,
            ),
          ),
        ),
      ],
    );
  }
}





















