import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messenger/networking/firebase_auth_client.dart';

class MessageInfo {
  String text;
  bool fromCurrentUser;
  DateTime dateTime;

  MessageInfo({
    required this.text,
    required this.fromCurrentUser,
    required this.dateTime,
  });

  factory MessageInfo.fromDoc(Map<String, dynamic> data) {
    String userId = FirebaseAuthClient().auth.currentUser!.uid;
    Timestamp stamp = Timestamp.fromMillisecondsSinceEpoch(data['timestamp']);
    return MessageInfo(
      text: data['text'],
      fromCurrentUser: data['userId'] == userId,
      dateTime: stamp.toDate(),
    );
  }
}
