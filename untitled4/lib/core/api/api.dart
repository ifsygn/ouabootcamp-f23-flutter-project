import 'package:cloud_firestore/cloud_firestore.dart';

class Api{
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final String path;
  late CollectionReference ref;

  Api( this.path ) {
    ref = firestore.collection(path);
  }

  Future<QuerySnapshot> getDataCollection() {
    return ref.get() ;
  }
  Stream<QuerySnapshot> streamDataCollection() {
    return ref.snapshots() ;
  }
  Future<DocumentSnapshot> getDocumentById(String id) {
    return ref.doc(id).get();
  }
  Future<void> removeDocument(String id){
    return ref.doc(id).delete();
  }
  Future<DocumentReference> addDocument(Map data) {
    return ref.add(data);
  }
  Future<void> updateDocument(Map<Object, Object?> data, String id) {
    return ref.doc(id).update(data) ;
  }
}