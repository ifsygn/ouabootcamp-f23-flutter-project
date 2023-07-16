import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:untitled4/core/data/entity/blog.dart';

class BlogDetailPage extends StatefulWidget {
  final MyBlogModel myModel;

  const BlogDetailPage({Key? key, required this.myModel}) : super(key: key);
  @override
  State<BlogDetailPage> createState() => _BlogDetailPageState();
}

String? imageUrl;

class _BlogDetailPageState extends State<BlogDetailPage> {
  Future pullFile() async {
    if (true) {
      final file = await FirebaseStorage.instance.ref(widget.myModel.imageName).getDownloadURL();
      setState(() {
        imageUrl = file.toString();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    pullFile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[100],
      body: SingleChildScrollView( // Değişiklik burada
        child: Column(
          children: [
            SizedBox(
              height: 430,
              child: Stack(
                children: [
                  imageUrl != null
                      ? Image.network(
                    imageUrl!,
                    height: 430,
                    width: 420,
                    fit: BoxFit.cover,
                  )
                      : const Text('no found image'),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      height: 40,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(42),
                          topRight: Radius.circular(42),
                        ),
                        color: Colors.purple[100],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(top: 50, left: 10),
                        child: Icon(
                          Icons.arrow_back,
                          size: 35,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.myModel.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50), // Ek padding eklendi
              child: SingleChildScrollView( // Değişiklik burada
                child: Text(
                  widget.myModel.subTitle,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
