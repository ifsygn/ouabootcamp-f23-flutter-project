//repo


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:untitled4/core/data/entity/blog.dart';

String? imageUrl;

class MyModelService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<MyBlogModel>> getMyModels() async {
    QuerySnapshot querySnapshot = await _firestore.collection('blog').get();
    List<MyBlogModel> myModels = [];
    for (var documentSnapshot in querySnapshot.docs) {
      myModels.add(MyBlogModel.fromSnapshot(documentSnapshot));
    }
    return myModels;
  }
  Future<List<MyBlogModel>> searchMyModels(String query) async {
    QuerySnapshot querySnapshot = await _firestore
        .collection('blog')
        .where('title', isGreaterThanOrEqualTo: query)
        .where('title', isLessThan: '${query}z')
        .get();
    List<MyBlogModel> searchResults = [];
    for (var documentSnapshot in querySnapshot.docs) {
      searchResults.add(MyBlogModel.fromSnapshot(documentSnapshot));
    }
    return searchResults;
  }

  Future<List<MyBlogModel>> getPopularMyModels() async {
    QuerySnapshot querySnapshot= await _firestore.collection('blog').get();
    List<MyBlogModel> popularMyModels= [];
    for(var documentSnapshot in querySnapshot.docs){
      MyBlogModel myModel= MyBlogModel.fromSnapshot(documentSnapshot);
      if(myModel.popularity){
        popularMyModels.add(myModel);
      }
    }
    return popularMyModels;
  }

  Future<String?> downloadImage(String myModelImage) async {
    try {
      final ref = FirebaseStorage.instance.ref(myModelImage).getDownloadURL();
      return ref;
    } catch (e) {
      if (kDebugMode) {
        print('Dosya indirme hatası: $e');
      }
      return null;
    }
  }
  Future<void> addMyModel(MyBlogModel myModel) async {
    MyBlogModel newModel = MyBlogModel(
      imageName: myModel.imageName,
      title: myModel.title,
      subTitle: myModel.subTitle,
      popularity: myModel.popularity,
      imageUrl: myModel.imageUrl,
    );
    _firestore.collection('blog').add(newModel.toMap()).then((value) {
      if (kDebugMode) {
        print("Veri Eklendi");
      }
    }).catchError((error) {
      if (kDebugMode) {
        print("Veri eklenemedi: $error");
      }
    });
  }
}