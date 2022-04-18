import 'package:shopping_list/utils/helpers.dart';

class ListModel {
  final int id;
  final String name;
  final bool isCompleted;
  final String createdAt;

  ListModel({
    required this.id,
    required this.name,
    this.isCompleted = false,
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
      createdAt: formatDate(jsonData['created_at']),
    );
  }
}
