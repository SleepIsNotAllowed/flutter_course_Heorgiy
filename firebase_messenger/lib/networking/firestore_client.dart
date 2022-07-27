import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messenger/networking/firebase_auth_client.dart';

class FirestoreClient {
  final int queryItemsNumber = 30; // number of items fetched by queries
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth authClient = FirebaseAuthClient().auth;

  Future<void> createUserRecord(String name, int colorIndex) async {
    String currentUserId = authClient.currentUser!.uid;
    await firestore
        .collection('usersList')
        .doc(currentUserId)
        .set(<String, dynamic>{
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'name': name,
      'userId': currentUserId,
      'thumbnailColor': colorIndex,
    });
  }

  Future<void> updateUserPresence() async {
    String currentUserId = authClient.currentUser!.uid;
    await firestore
        .collection('usersList')
        .doc(currentUserId)
        .set(<String, dynamic>{
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    }, SetOptions(merge: true));
  }

  Stream availablePartakersStream() {
    String userId = authClient.currentUser!.uid;
    return firestore
        .collection('usersList')
        .where('userId', isNotEqualTo: userId)
        .orderBy('userId')
        .orderBy('name')
        .snapshots();
  }

  Stream availableChatsStream() {
    String userId = authClient.currentUser!.uid;
    return firestore
        .collection('chatsInfo')
        .where('partakers', arrayContains: userId)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  Stream newMessagesStream(String chatName, int timestamp) {
    return firestore
        .collection('chatsInfo')
        .doc(chatName)
        .collection('messages')
        .where('timestamp', isGreaterThan: timestamp)
        .orderBy('timestamp', descending: true)
        .limit(1)
        .snapshots();
  }

  Stream partakerPresenceStream(String partakerId) {
    return firestore.collection('usersList').doc(partakerId).snapshots();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> initialFetchOfOldMessages(
      String chatName) async {
    return firestore
        .collection('chatsInfo')
        .doc(chatName)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .limit(queryItemsNumber)
        .get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> fetchOldMessagesBatch(
      String chatName, int cursor) async {
    return firestore
        .collection('chatsInfo')
        .doc(chatName)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .startAfter([cursor])
        .limit(queryItemsNumber)
        .get();
  }

  Future<void> createChatReferences(String partakerId, String chatName) async {
    String userId = authClient.currentUser!.uid;
    await firestore.collection('chatsInfo').doc(chatName).set(
      <String, dynamic>{
        'partakers': [userId, partakerId],
        'chatName': chatName,
      },
    );
  }

  Future<void> sendMessage(
      String text, String userId, int timestamp, String chatName) async {
    try {
      await firestore.runTransaction((transaction) async {
        firestore
            .collection('chatsInfo')
            .doc(chatName)
            .set(<String, dynamic>{
          'lastMessage': text,
          'timestamp': timestamp,
        }, SetOptions(merge: true));
        firestore
            .collection('chatsInfo')
            .doc(chatName)
            .collection('messages')
            .add(<String, dynamic>{
          'text': text,
          'userId': userId,
          'timestamp': timestamp,
          'isRead': false,
        });
      });
    } on Exception catch (exception) {
      print(exception.toString());
    }
  }
}
