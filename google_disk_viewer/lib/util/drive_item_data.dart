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
    String sizeString;
    if (json['size'] == null) {
      sizeString = 'N/A';
    } else {
      double size = double.parse(json['size']);
      if (size * 0.000001 > 0.5) {
        sizeString = (size * 0.000001).toStringAsFixed(2) + ' MB';
      } else {
        sizeString = (size * 0.001).round().toString() + ' KB';
      }
    }

    return DriveItemData(
      id: json['id'],
      name: json['name'],
      iconLink: json['iconLink'],
      createdTime: json['createdTime'],
      size: sizeString,
      thumbnail: json['thumbnailLink'],
    );
  }
}
