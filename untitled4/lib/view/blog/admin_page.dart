import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:untitled4/core/data/entity/blog.dart';
import 'package:untitled4/core/data/repository/blog_repository.dart';
class AdminPage extends StatefulWidget {
  const AdminPage({super.key});
  @override
  State<AdminPage> createState() => _AdminPageState();
}
final _titleController = TextEditingController();
final _subtitleController = TextEditingController();
final MyModelService myModelService = MyModelService();
bool populartiy = false;
PlatformFile? pickedFile;
UploadTask? uploadTask;
String? imageUrl;
void _copyToClipboard(BuildContext context, String text) {
  Clipboard.setData(ClipboardData(text: text));
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(text)),
  );
}
class _AdminPageState extends State<AdminPage> {
  Future saveButtonClick() async {
    if (imageUrl != null) {
      if (_titleController.text.isEmpty) {
        _copyToClipboard(context, 'Veri girişi yapmayı unuttunuz.');
      }
      else if (_subtitleController.text.isEmpty) {
        _copyToClipboard(context, 'Veri girişi yapmayı unuttunuz.');
      }
      else {
        uploadFile();
        MyBlogModel newModel = MyBlogModel(
            imageName: '$imageUrl',
            title: _titleController.text,
            subTitle: _subtitleController.text,
            popularity: populartiy,
            imageUrl: imageUrl!
        );
        myModelService.addMyModel(newModel);
      }
    }
    else {
      _copyToClipboard(context, 'Resim Seçmeyi Unuttunuz');
    }
  }
  Future uploadFile() async {
    final path = pickedFile!.name;
    final file = File(pickedFile!.path!);

    final ref = FirebaseStorage.instance.ref().child(path);

    setState(() {
      uploadTask = ref.putFile(file);
    });

    final snapshot = await uploadTask!.whenComplete(() {});

    var downloadUrl = await snapshot.ref.getDownloadURL();
    if (kDebugMode) {
      print('Download Link: $downloadUrl');
    }
    setState(() {
      uploadTask = null;
    });
  }

  Future pullFile() async {
    if (true) {
      final file = await FirebaseStorage.instance.ref(
          'files/IMG_20230711_221334.jpg').getDownloadURL();
      setState(() {
        imageUrl = file.toString();
      });
    }
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;
    setState(() {
      pickedFile = result.files.first;
      imageUrl = pickedFile?.name;
      if (kDebugMode) {
        print('resmin ismi $pickedFile?.name');
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          SizedBox(
            height: 430,
            child: DecoratedBox(
              decoration: const BoxDecoration(
                color: Color.fromARGB(100, 224, 224, 224),
              ),
              child: Stack(
                children: [
                  pickedFile != null
                      ?
                  PickedImage(pickedFile: pickedFile) :
                  const Padding(
                    padding: EdgeInsets.all(100.0),
                    child: Icon(
                      Icons.image,
                      size: 175,
                    ),
                  ),
                  addIconButton(),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 40,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(42),
                          topRight: Radius.circular(42),
                        ),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              child: TitleTextField(controller: _titleController),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              child: SubtitleTextField(controller: _subtitleController),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: ToogleSwitch(),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(onPressed: saveButtonClick,
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFCE8BF8)), child: Container(
                width: 170.0,
                height: 45.0,
                alignment: Alignment.center,
                child: const Text('Kaydet',
                    style: TextStyle(fontSize: 20.0, color: Colors.white)),
              ),
            ),
          ),
          buildProgress(),
        ],
      ),
    );

  }
  IconButton addIconButton() {
    return IconButton(
      onPressed: () {
        selectFile();
      },
      padding: const EdgeInsets.only(left: 280, top: 100),
      icon: const Icon(
        Icons.add,
        size: 45,
      ),
    );
  }
  Widget buildProgress() => StreamBuilder<TaskSnapshot>(
      stream: uploadTask?.snapshotEvents,
      builder: (context, snapshot){
        if(snapshot.hasData){
          final data = snapshot.data!;
          double progress=data.bytesTransferred/data.totalBytes;
          return SizedBox(
            height: 50,
            child: Stack(
              fit: StackFit.expand,
              children: [
                LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.grey,
                  color: Colors.green,
                ),
                Center(
                  child: Text('${(100*progress).roundToDouble()}%',style: const TextStyle(color: Colors.white),),
                )
              ],
            ),
          );
        }
        else{
          return const SizedBox(height: 50,);
        }

      });
}
class PickedImage extends StatelessWidget {
  const PickedImage({
    Key? key,
    required this.pickedFile,
  }) : super(key: key);

  final PlatformFile? pickedFile;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 100, top: 100),
          child: Image.file(
            File(
                pickedFile!.path!
            ),
            width: 175,
            height: 175,
          ),
        ),
        //Image.file(File(pickedFile!.path!)),
      ],
    );
  }
}
class ToogleSwitch extends StatelessWidget {
  const ToogleSwitch({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text('Populer bloglara eklensin mi?'),
        const SizedBox(
          width: 20,
        ),
        ToggleSwitch(
          activeBgColor: const [
            Color(0xFFCE8BF8),
          ],
          inactiveBgColor: Colors.grey[300],
          inactiveFgColor: Colors.black,
          initialLabelIndex: 0,
          totalSwitches: 2,
          labels: const [
            'Hayır',
            'Evet',
          ],
          onToggle: (index) {
            if (index == 1) {
              populartiy = true;
              if (kDebugMode) {
                print("Evet işaretlendi $populartiy");
              }
            }
            else {
              populartiy = false;
              if (kDebugMode) {
                print("Hayır işaretlendi $populartiy");
              }
            }
          },
        ),
      ],
    );
  }
}
class SubtitleTextField extends StatelessWidget {
  final TextEditingController controller;

  const SubtitleTextField({super.key, required this.controller});


  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: controller,
            decoration: const InputDecoration(
              labelText: 'İçerik Ekleyin',
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }
}
class TitleTextField extends StatelessWidget {
  final TextEditingController controller;

  const TitleTextField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: controller,
            decoration: const InputDecoration(
              labelText: 'Başlık Ekleyin',
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }
}