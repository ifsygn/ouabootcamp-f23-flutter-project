// ignore_for_file: prefer_const_declarations
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(
    const MaterialApp(
      home: UserProfileEditPage(),
    ),
  );
}

class UserProfileEditPage extends StatefulWidget {
  const UserProfileEditPage({Key? key}) : super(key: key);

  @override
  _UserProfileEditPageState createState() => _UserProfileEditPageState();
}

class _UserProfileEditPageState extends State<UserProfileEditPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _birthDateController = TextEditingController();

  String name = '';
  String contact = ''; // Corrected the variable name
  late String email;
  String summary = '';
  String city = '';
  DateTime? birthdate;

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
      contact = '+905551112233';
      email = 'aleyna.toprak@gmail.com';
      summary = 'Bu alana özet bilgi gelecektir.';
      city = 'Ankara';
      birthdate = DateTime(2021, 1, 1);

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
      print('İletişim: $contact');
      print('E Posta: $email');
      print('Özet: $summary');
      print('Şehir: $city');
      print('Doğum Günü: $birthdate');
    }
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
                              "https://images.pexels.com/photos/3307758/pexels-photo-3307758.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=250",
                            ),
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
                        'PROFİL',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      const Divider(),
                      const SizedBox(height: 10.0),
                      _buildEditRow('Ad Soyad', name, TextInputType.text),
                      const SizedBox(height: 15.0),
                      _buildEditRow('İletişim', contact, TextInputType.text),
                      const SizedBox(height: 15.0),
                      _buildEditRow('E Posta', email, TextInputType.text),
                      const Divider(),
                      const SizedBox(height: 15.0),
                      _buildEditRow('Özet', summary, TextInputType.text),
                      const Divider(),
                      const SizedBox(height: 15.0),
                      _buildEditRow('Şehir', city, TextInputType.text),
                      const SizedBox(height: 15.0),
                      _buildEditRow('Doğum Günü', _birthDateController.text,
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

  Widget _buildEditRow(String label, String value, TextInputType? inputType) {
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
            initialValue: label == 'Doğum Günü'
                ? _birthDateController.text
                : value,
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
                  contact = newValue;
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
            maxLines: label == 'Özet' ? 3 : 1, // Özet alanı için maksimum 3 satır
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
    // Replace this with your actual database implementation
    name = name.trim();
    contact = contact.trim();
    // Save the data...
  }
}