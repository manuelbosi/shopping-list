import 'package:shopping_list/config/app_config.dart';

class Market {
  final int id;
  final String name;
  final String imageUrl;

  const Market({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  factory Market.fromJson(Map<String, dynamic> jsonData) {
    return Market(
      id: jsonData['id'],
      name: jsonData['name'],
      imageUrl: "${AppConfig.storageUrl}${jsonData['image']}",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': imageUrl,
    };
  }
}
