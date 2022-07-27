import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messenger/networking/firebase_auth_client.dart';

class MessageInfo {
  String text;
  bool fromCurrentUser;
  bool isRead;
  DateTime dateTime;
  String messageId;

  MessageInfo({
    required this.text,
    required this.fromCurrentUser,
    required this.isRead,
    required this.dateTime,
    required this.messageId,
  });

  factory MessageInfo.fromDoc(Map<String, dynamic> data, String messageId) {
    String userId = FirebaseAuthClient().auth.currentUser!.uid;
    Timestamp stamp = Timestamp.fromMillisecondsSinceEpoch(data['timestamp']);
    return MessageInfo(
      text: data['text'],
      fromCurrentUser: data['userId'] == userId,
      isRead: data['isRead'],
      dateTime: stamp.toDate(),
      messageId: messageId,
    );
  }
}
