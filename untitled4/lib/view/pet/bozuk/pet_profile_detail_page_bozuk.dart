// ignore_for_file: prefer_const_declarations

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(
    const MaterialApp(
      home: PetProfileDetailPage(),
    ),
  );
}

class PetProfileDetailPage extends StatefulWidget {
  const PetProfileDetailPage({Key? key}) : super(key: key);

  @override
  _PetProfileDetailPageState createState() => _PetProfileDetailPageState();
}

class _PetProfileDetailPageState extends State<PetProfileDetailPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _birthDateController = TextEditingController();

  String animalName = '';
  String animalStrain = '';
  int? animalAge;
  double? animalWeight;
  DateTime? animalBirthdate;
  File? selectedImage;

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
      selectedImage = null;

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
      print('İSİM: $animalName');
      print('CİNS: $animalStrain');
      print('YAŞ: $animalAge');
      print('KİLO: $animalWeight');
      print('DOĞUM GÜNÜ: $animalBirthdate');
      print('RESİM URL: ${selectedImage?.path}');
    }
  }

  Future<void> _selectImageFromGallery() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedImage =
    await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        selectedImage = File(pickedImage.path);
      });
    }
  }

  Widget _buildProfileImage() {
    final defaultImageURL =
        "https://images.dog.ceo/breeds/finnish-lapphund/mochilamvan.jpg";

    if (selectedImage != null && selectedImage!.existsSync()) {
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
          image: DecorationImage(
            fit: BoxFit.cover,
            image: FileImage(selectedImage!),
          ),
        ),
      );
    } else {
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
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(defaultImageURL),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: iconbackbutton(),
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
              child: textkaydet(),
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
                            icon: cameraicon(),
                            onPressed: _selectImageFromGallery,
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
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(right: 20, left: 10),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.10),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        texthayvanprofili(),
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

class texthayvanprofili extends StatelessWidget {
  const texthayvanprofili({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Text(
      'HAYVAN PROFİLİ',
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      textAlign: TextAlign.left,
    );
  }
}

class cameraicon extends StatelessWidget {
  const cameraicon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.photo_camera,
      color: Colors.white,
    );
  }
}

class textkaydet extends StatelessWidget {
  const textkaydet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Text(
      'KAYDET',
      style: TextStyle(
        fontSize: 18,
        letterSpacing: 3.3,
        color: Colors.purple,
      ),
    );
  }
}

class iconbackbutton extends StatelessWidget {
  const iconbackbutton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.arrow_back,
      color: Colors.purple,
    );
  }
}
