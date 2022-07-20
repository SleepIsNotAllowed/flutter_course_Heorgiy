import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreClient {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream getUsersListStream() {
    return firestore
        .collection('usersList')
        .orderBy('name')
        .snapshots();
  }
}