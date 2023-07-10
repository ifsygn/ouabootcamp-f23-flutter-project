import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';


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
          Container(
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
                  primary: const Color(0xFFCE8BF8),
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



/*
Bu kod, Flutter framework'ü kullanılarak bir mobil uygulama geliştirmek için kullanılan bir yapıya sahiptir. Kodda hem frontend hem de backend kısmı bulunmaktadır. İşlevleri aşağıda ayrıntılı olarak açıklanmıştır:

İmportlar: flutter/material.dart paketi içindeki sınıfları kullanabilmek için import ifadesi kullanılır.

main() Fonksiyonu: Uygulamanın başlangıç noktasıdır. runApp() fonksiyonu, MyApp widget'ını başlatır.

MyApp Sınıfı: StatelessWidget sınıfından türetilmiştir ve uygulamanın ana widget'ıdır. MaterialApp widget'ını döndürür.

MaterialApp Widget'ı: MaterialApp, temel uygulama bileşenlerini oluşturur ve konfigüre eder. Ana sayfa olarak ShelterPage widget'ını kullanır.

BackgroundImageWidget Sınıfı: Arka plan resmi eklemek için kullanılan bir widget'tır. child parametresi olarak alınan başka bir widget'ı içerir.

ShelterPage Sınıfı: Stateful widget sınıfından türetilmiştir ve barınak sayfasını oluşturur. Barınak adı, barınak bilgileri, barınak görüntüleri, hayvan adları ve hayvan yaşları gibi değişkenleri içerir. initState() fonksiyonu, veritabanından gerekli bilgileri çekmek için kullanılabilir. build() fonksiyonu ise sayfanın içeriğini oluşturur.

ShelterPageContent Sınıfı: Barınak sayfasının içeriğini oluşturan bir widget'tır. Arka plan resmini içeren BackgroundImageWidget widget'ını kullanır. Şelter adını, bilgilerini, resimlerini, hayvan adlarını ve hayvan yaşlarını parametre olarak alır.

BackButtonWidget Sınıfı: Sayfanın sol üst köşesinde geri dönüş düğmesini oluşturan bir widget'tır. IconButton kullanır.

AnimalCard Sınıfı: Hayvan kartlarını oluşturan bir widget'tır. Hayvan resmi, adı ve yaşını parametre olarak alır ve ListTile widget'ını kullanarak bilgileri görüntüler.

Bu kod parçacığı, bir barınak sayfasını göstermek için kullanılan bir Flutter uygulamasının frontend kısmını içerir.
Arka plan resmi, geri dönüş düğmesi, barınak adı, barınak bilgileri, barınak görüntüleri, hayvan adları ve hayvan yaşları gibi bileşenleri içeren bir kullanıcı arayüzü oluşturur.
Backend kısmı, veritabanından gerekli bilgileri çekmek ve düğmelere basıldığında yapılacak işlemleri gerçekleştirmek için geliştirilmelidir
Veritabanından bilgileri çekmek için initState() fonksiyonu kullanılabilir ve düğmelere basıldığında yapılacak işlemler ilgili düğme on pressed fonksiyonlarına eklenmelidir.
Ancak, bu kod parçacığı içerisinde veritabanı bağlantısı veya düğmelere basıldığında gerçekleştirilecek işlemlere dair herhangi bir kod bulunmamaktadır. Bu nedenle, backend kısmı eksik kalmıştır.
Tam bir uygulama geliştirmek için backend tarafının da oluşturulması ve ilgili veritabanı işlemlerinin gerçekleştirilmesi gerekmektedir.
 */