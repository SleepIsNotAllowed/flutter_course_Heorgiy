class DriveItemData {
  final String id;
  final String name;
  final String iconLink;
  final String createdTime;
  final String size;
  final String? thumbnail;

  const DriveItemData({
    required this.id,
    required this.name,
    required this.iconLink,
    required this.createdTime,
    required this.size,
    required this.thumbnail,
  });

  factory DriveItemData.fromJson(Map<dynamic, dynamic> json) {
    return DriveItemData(
      id: json['id'],
      name: json['name'],
      iconLink: json['iconLink'],
      createdTime: json['createdTime'],
      size: json['size'] == null
          ? 'N/A'
          : ((int.parse(json['size']) * 0.000125).round()).toString() + ' Kb',
      thumbnail: json['thumbnailLink'],
    );
  }
}
