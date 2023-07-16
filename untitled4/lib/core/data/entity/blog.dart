//entity

import 'package:cloud_firestore/cloud_firestore.dart';

class MyBlogModel {
  final String imageName;
  final String title;
  final String subTitle;
  final bool popularity;
  String imageUrl;

  MyBlogModel({
    required this.imageName,
    required this.title,
    required this.subTitle,
    required this.popularity,
    required this.imageUrl,

  });

  factory MyBlogModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return MyBlogModel(
      imageName: data['imageName'] as String,
      title: data['title'] as String,
      subTitle: data['subtitle'] as String,
      popularity: data['popularity'] as bool,
      imageUrl: data['imageUrl']as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'imageName': imageName,
      'title': title,
      'subtitle': subTitle,
      'popularity' : popularity,
      'imageUrl': imageUrl,

    };
  }
}