import 'package:flutter/material.dart';

class UserContactInfo {
  String name;
  String userId;
  Color thumbnailColor;

  UserContactInfo({
    required this.name,
    required this.userId,
    required this.thumbnailColor,
  });

  factory UserContactInfo.fromDoc(Map<String, dynamic> data) {
    return UserContactInfo(
      name: data['name'],
      userId: data['userId'],
      thumbnailColor: Colors.primaries[data['thumbnailColor']],
    );
  }
}
