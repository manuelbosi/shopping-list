import 'package:shopping_list/utils/helpers.dart';

class ListModel {
  final int? id;
  final String name;
  final bool isCompleted;
  final int marketId;
  final String createdAt;

  ListModel({
    this.id,
    required this.name,
    this.isCompleted = false,
    required this.marketId,
    required this.createdAt,
  });

  factory ListModel.fromJson(Map<String, dynamic>? jsonData) {
    if (jsonData == null) {
      throw Exception("Json data cannot be null");
    }
    return ListModel(
      id: jsonData['id'],
      name: jsonData['name'],
      isCompleted: jsonData['is_completed'],
      marketId: jsonData['market_id'],
      createdAt: formatDate(jsonData['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'is_completed': isCompleted,
      'market_id': marketId,
      'created_at': createdAt,
    };
  }
}
