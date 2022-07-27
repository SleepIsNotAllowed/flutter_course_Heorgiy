import 'package:flutter/material.dart';

class UserContactInfo {
  DateTime lastUpdated;
  String name;
  String userId;
  Color thumbnailColor;

  UserContactInfo({
    required this.lastUpdated,
    required this.name,
    required this.userId,
    required this.thumbnailColor,
  });

  factory UserContactInfo.fromDoc(Map<String, dynamic> data) {
    return UserContactInfo(
      lastUpdated: DateTime.fromMillisecondsSinceEpoch(data['timestamp']),
      name: data['name'],
      userId: data['userId'],
      thumbnailColor: Colors.primaries[data['thumbnailColor']],
    );
  }
}
