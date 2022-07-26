import 'package:firebase_messenger/networking/firebase_auth_client.dart';

class ChatInfo {
  String chatName;
  String lastMessage;
  String partakerId;

  ChatInfo({
    required this.chatName,
    required this.lastMessage,
    required this.partakerId,
  });

  factory ChatInfo.fromDoc(Map<String, dynamic> data) {
    List<dynamic> partakers = data['partakers'];
    String userId = FirebaseAuthClient().auth.currentUser!.uid;
    return ChatInfo(
      chatName: data['chatName'],
      lastMessage: data['lastMessage'],
      partakerId: partakers[0] != userId ? partakers[0] : partakers[1],
    );
  }
}
