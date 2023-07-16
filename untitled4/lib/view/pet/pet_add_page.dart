import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PetAddPage extends StatefulWidget {
  const PetAddPage({Key? key}) : super(key: key);

  @override
  _PetAddPageState createState() => _PetAddPageState();
}

class _PetAddPageState extends State<PetAddPage> {
  TextEditingController isimController = TextEditingController();
  TextEditingController cinsController = TextEditingController();
  TextEditingController yasController = TextEditingController();
  TextEditingController kiloController = TextEditingController();
  TextEditingController dogumgunuController = TextEditingController();

  int yas = 0;
  int kilo = 0;
  late DateTime dogumgunu;

  void saveProfile() {
    String isim = isimController.text;
    String cins = cinsController.text;
    int yas = int.tryParse(yasController.text) ?? 0;
    int kilo = int.tryParse(kiloController.text) ?? 0;
    String dogumgunu = dogumgunuController.text;

    // TODO: Dosyayı veritabanına kaydetme işlemini burada gerçekleştirin
    // Örneğin: Firestore veya Firebase Storage kullanabilirsiniz

    // TODO: dogumgunuController ile kaydetme işlemini burada gerçekleştirin
    // Veritabanına kaydedin veya güncelleyin

    // Örnek olarak, verileri konsola yazdıralım
    print('İsim: $isim');
    print('Cins: $cins');
    print('Yaş: $yas');
    print('Kilo: $kilo');
    print('Doğum Günü: $dogumgunu');
  }

  Widget _buildProfileImage() {
    return Container(
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
          )
        ],
        color: Colors.grey.withOpacity(0.3),
        borderRadius: BorderRadius.circular(30.0),
        image: const DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
            "https://images.dog.ceo/breeds/finnish-lapphund/mochilamvan.jpg",
          ),
        ),
      ),
    );
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
            child: TextButton(
              onPressed: saveProfile,
              child: const Text(
                'KAYDET',
                style: TextStyle(
                  fontSize: 18,
                  letterSpacing: 3.3,
                  color: Colors.purple,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('images/flat.jpg'),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20.0),
              Center(
                child: Stack(
                  children: [
                    _buildProfileImage(),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                          color: Colors.purple,
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.photo_camera,
                            color: Colors.white,
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ),
                  ],
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
                margin: const EdgeInsets.only(right: 20, left: 10),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.10),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 1.0),
                      child: Text(
                        'HAYVAN PROFİLİ',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    const Divider(),
                    TextFormField(
                      controller: isimController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        labelText: 'İSİM',
                        hintText: 'İSİM girin',
                      ),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    TextFormField(
                      controller: cinsController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        labelText: 'CİNS',
                        hintText: 'Cins bilgisini girin',
                      ),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      controller: yasController,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        labelText: 'YAŞ',
                        hintText: 'Yaş bilgisini girin',
                      ),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    TextFormField(
                      controller: kiloController,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        labelText: 'KİLO',
                        hintText: 'Kilo bilgisini girin',
                      ),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    TextFormField(
                      controller: dogumgunuController,
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2100),
                        );
                        if (pickedDate != null) {
                          setState(() {
                            dogumgunu = DateTime(
                              pickedDate.year,
                              pickedDate.month,
                              pickedDate.day,
                            );
                            dogumgunuController.text =
                            '${pickedDate.day}/${pickedDate.month}/${pickedDate.year}';
                          });
                        }
                      },
                      readOnly: true,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        labelText: 'DOĞUM GÜNÜ',
                        hintText: 'Doğum Günü bilgisini seçin',
                      ),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: PetAddPage(),
  ));
}