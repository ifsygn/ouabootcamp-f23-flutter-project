// ignore_for_file: prefer_const_declarations

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(
    const MaterialApp(
      home: UserProfileDetailPage(),
    ),
  );
}

class UserProfileDetailPage extends StatefulWidget {
  const UserProfileDetailPage({Key? key}) : super(key: key);

  @override
  _UserProfileDetailPageState createState() => _UserProfileDetailPageState();
}

class _UserProfileDetailPageState extends State<UserProfileDetailPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _birthDateController = TextEditingController();

  String name = '';
  String cantact = '';
  late String email;
  String summary = '';
  String city = '';
  DateTime? birthdate;
  File? selectedImage;

  @override
  void initState() {
    super.initState();
    _birthDateController.text = birthdate != null
        ? '${birthdate!.day}/${birthdate!.month}/${birthdate!.year}'
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
      name = 'Aleyna Toprak';
      cantact = '+905551112233';
      email = 'aleyna.toprak@gmail.com';
      summary = 'Bu alana özet bilgi gelecektir.';
      city = 'Ankara';
      birthdate = DateTime(2021, 1, 1);
      selectedImage = null;

      _birthDateController.text = birthdate != null
          ? '${birthdate!.day}/${birthdate!.month}/${birthdate!.year}'
          : '';
    });
  }

  void kaydetButtonPressed() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Save data to the database
      saveDataToDatabase();

      // Print the values to the console
      print('Ad Soyad: $name');
      print('iletişim: $cantact');
      print('E Posta: $email');
      print('Özet: $summary');
      print('Şehir: $city');
      print('DOĞUM GÜNÜ: $birthdate');
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
        "https://images.pexels.com/photos/3307758/pexels-photo-3307758.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=250";

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
        leading: iconbackbutton(),
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
                        profiltext(),
                        const Divider(),
                        const SizedBox(height: 10.0),
                        _buildDetailRow('Ad Soyad', name, TextInputType.text),
                        const SizedBox(height: 15.0),
                        _buildDetailRow(
                            'İletişim', cantact, TextInputType.text),
                        const SizedBox(height: 15.0),
                        _buildDetailRow('E Posta', email, TextInputType.text),
                        const Divider(),
                        const SizedBox(height: 15.0),
                        _buildDetailRow('Özet', summary, TextInputType.text),
                        const Divider(),
                        const SizedBox(height: 15.0),
                        _buildDetailRow('Şehir', city, TextInputType.text),
                        const SizedBox(height: 15.0),
                        _buildDetailRow(
                            'Doğum Günü',
                            birthdate != null
                                ? birthdate!.toString().substring(0, 10)
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
          child: label == 'Doğum Günü'
              ? InkWell(
            onTap: () {
              _showDatePicker();
            },
            child: AbsorbPointer(
              child: TextFormField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: value,
                  hintStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  contentPadding: EdgeInsets.zero,
                ),
                readOnly: true,
                controller: _birthDateController,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
                onTap: () {
                  _showDatePicker();
                },
                onChanged: (newValue) {
                  setState(() {
                    if (label == 'Doğum Günü') {
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
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: value,
              hintStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              contentPadding: EdgeInsets.zero,
              counterText:
              '', // Özet alanı için karakter sayısı görüntülenmemesi için
            ),
            initialValue: value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: Colors.black,
            ),
            onChanged: (newValue) {
              setState(() {
                if (label == 'Ad Soyad') {
                  name = newValue;
                } else if (label == 'İletişim') {
                  cantact = newValue;
                } else if (label == 'E Posta') {
                  email = newValue;
                } else if (label == 'Özet') {
                  summary = newValue.length <= 100
                      ? newValue
                      : newValue.substring(
                      0, 100); // Maksimum 100 karaktere sınırlama
                } else if (label == 'Şehir') {
                  city = newValue;
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
            maxLines: label == 'Özet'
                ? 3
                : 1, // Özet alanı için maksimum 3 satır
            maxLength: (label == 'Özet' ||
                label == 'Ad Soyad' ||
                label == 'Şehir' ||
                label == 'İletişim' ||
                label == 'E Posta')
                ? 100
                : null, // Özet alanı için maksimum 100 karakter
          ),
        ),
      ],
    );
  }

  Future<void> _showDatePicker() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: birthdate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      setState(() {
        birthdate = pickedDate;
        _birthDateController.text =
        '${pickedDate.day.toString().padLeft(2, '0')}/${pickedDate.month.toString().padLeft(2, '0')}/${pickedDate.year.toString()}';
      });
    }
  }

  void saveDataToDatabase() {
    // Simulating saving data to a database
    // You can replace this with your actual implementation
    name = name.trim();
    cantact = cantact.trim();
    // Save the data...
  }
}

class profiltext extends StatelessWidget {
  const profiltext({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Text(
      'PROFİL',
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
    return IconButton(
      icon: const Icon(
        Icons.arrow_back,
        color: Colors.purple,
      ),
      onPressed: () {},
    );
  }
}