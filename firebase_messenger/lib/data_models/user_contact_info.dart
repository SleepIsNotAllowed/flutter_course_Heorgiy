import 'package:flutter/material.dart';

class UserContactInfo {
  DateTime lastSeen;
  String name;
  String userId;
  Color thumbnailColor;
  bool isOffline;

  UserContactInfo({
    required this.lastSeen,
    required this.name,
    required this.userId,
    required this.thumbnailColor,
    required this.isOffline,
  });

  factory UserContactInfo.fromDoc(Map<String, dynamic> data) {
    DateTime lasSeen = DateTime.fromMillisecondsSinceEpoch(data['timestamp']);
    bool isOffline = DateTime.now().difference(lasSeen).inMinutes > 2;
    return UserContactInfo(
      lastSeen: lasSeen,
      name: data['name'],
      userId: data['userId'],
      thumbnailColor: Colors.primaries[data['thumbnailColor']],
      isOffline: isOffline,
    );
  }
}
