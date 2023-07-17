// ignore_for_file: prefer_const_declarations

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(
    const MaterialApp(
      home: PetProfilePage(),
    ),
  );
}

class PetProfilePage extends StatefulWidget {
  const PetProfilePage({Key? key}) : super(key: key);

  @override
  _PetProfilePageState createState() => _PetProfilePageState();
}

class _PetProfilePageState extends State<PetProfilePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _birthDateController = TextEditingController();

  String animalName = '';
  String animalStrain = '';
  int? animalAge;
  double? animalWeight;
  DateTime? animalBirthdate;

  @override
  void initState() {
    super.initState();
    _birthDateController.text = animalBirthdate != null
        ? '${animalBirthdate!.day}/${animalBirthdate!.month}/${animalBirthdate!.year}'
        : '';
    veritabanindanVeriGetir();
  }

  @override
  void dispose() {
    _birthDateController.dispose();
    super.dispose();
  }

  void veritabanindanVeriGetir() {
    // Simulating data retrieval from a database
    setState(() {
      animalName = 'Köpük';
      animalStrain = 'Scottish Fold';
      animalAge = 2;
      animalWeight = 4.0;
      animalBirthdate = DateTime(2021, 1, 1);

      _birthDateController.text = animalBirthdate != null
          ? '${animalBirthdate!.day}/${animalBirthdate!.month}/${animalBirthdate!.year}'
          : '';
    });
  }

  void kaydetButtonPressed() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Save data to the database
      saveDataToDatabase();

      // Print the values to the console
      /* print('İSİM: $animalName');
      print('CİNS: $animalStrain');
      print('YAŞ: $animalAge');
      print('KİLO: $animalWeight');
      print('DOĞUM GÜNÜ: $animalBirthdate');
      */
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
              onPressed: kaydetButtonPressed,
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
            image: AssetImage('images/flat.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40.0),
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
                            )
                          ],
                          color: Colors.grey.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(30.0),
                          image: const DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                "https://cdn.pixabay.com/photo/2014/11/30/14/11/cat-551554_1280.jpg"),
                          ),
                        ),
                      ),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'HAYVAN PROFİLİ',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      const Divider(),
                      const SizedBox(height: 10.0),
                      _buildDetailRow('İSİM', animalName, TextInputType.text),
                      const SizedBox(height: 25.0),
                      _buildDetailRow(
                          'CİNS', animalStrain, TextInputType.text),
                      const SizedBox(height: 25.0),
                      _buildDetailRow(
                          'YAŞ',
                          animalAge != null ? animalAge.toString() : '',
                          TextInputType.number),
                      const SizedBox(height: 25.0),
                      _buildDetailRow(
                          'KİLO',
                          animalWeight != null ? animalWeight.toString() : '',
                          const TextInputType.numberWithOptions(
                              decimal: true)),
                      const SizedBox(height: 25.0),
                      _buildDetailRow(
                          'DOĞUM GÜNÜ',
                          animalBirthdate != null
                              ? animalBirthdate!.toString().substring(0, 10)
                              : '',
                          TextInputType.datetime),
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

  Widget _buildDetailRow(String label, String value, TextInputType? inputType) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label + ":",
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(
          width: 200,
          child: label == 'DOĞUM GÜNÜ'
              ? InkWell(
            onTap: () {
              _showDatePicker();
            },
            child: AbsorbPointer(
              child: TextFormField(
                readOnly: true,
                controller: _birthDateController,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                onTap: () {
                  _showDatePicker();
                },
                onChanged: (newValue) {
                  setState(() {
                    if (label == 'DOĞUM GÜNÜ') {
                      _birthDateController.text = newValue;
                    }
                  });
                },
                keyboardType: inputType ?? TextInputType.text,
                inputFormatters: (inputType == TextInputType.number ||
                    inputType ==
                        const TextInputType.numberWithOptions(
                            decimal: true))
                    ? [
                  FilteringTextInputFormatter.allow(
                      RegExp(r'^\d*\.?\d*$'))
                ]
                    : null,
              ),
            ),
          )
              : TextFormField(
            initialValue: value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            onChanged: (newValue) {
              setState(() {
                if (label == 'İSİM') {
                  animalName = newValue;
                } else if (label == 'CİNS') {
                  animalStrain = newValue;
                } else if (label == 'YAŞ') {
                  animalAge = int.tryParse(newValue);
                } else if (label == 'KİLO') {
                  animalWeight = double.tryParse(newValue);
                }
              });
            },
            keyboardType: inputType ?? TextInputType.text,
            inputFormatters: (inputType == TextInputType.number ||
                inputType ==
                    const TextInputType.numberWithOptions(
                        decimal: true))
                ? [
              FilteringTextInputFormatter.allow(
                  RegExp(r'^\d*\.?\d*$'))
            ]
                : null,
          ),
        ),
      ],
    );
  }

  Future<void> _showDatePicker() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: animalBirthdate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      setState(() {
        animalBirthdate = pickedDate;
        _birthDateController.text =
        '${pickedDate.day.toString().padLeft(2, '0')}/${pickedDate.month.toString().padLeft(2, '0')}/${pickedDate.year.toString()}';
      });
    }
  }

  void saveDataToDatabase() {
    // Simulating saving data to a database
    // You can replace this with your actual implementation
    animalName = animalName.trim();
    animalStrain = animalStrain.trim();
    // Save the data...
  }
}

