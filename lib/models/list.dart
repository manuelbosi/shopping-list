import 'package:shopping_list/models/market.dart';
import 'package:shopping_list/utils/helpers.dart';

class ListModel {
  final int? id;
  final String name;
  final bool isCompleted;
  Market? market;
  final String createdAt;

  ListModel({
    this.id,
    required this.name,
    this.isCompleted = false,
    this.market,
    required this.createdAt,
  });

  factory ListModel.fromJson(Map<String, dynamic>? jsonData,
      [mapMarket = true]) {
    if (jsonData == null) {
      throw Exception("Json data cannot be null");
    }
    ListModel list = ListModel(
      id: jsonData['id'],
      name: jsonData['name'],
      isCompleted: jsonData['is_completed'],
      createdAt: formatDate(jsonData['created_at']),
    );
    if (mapMarket) {
      list.market = Market.fromJson(jsonData['market']);
    }
    return list;
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'is_completed': isCompleted,
      'market_id': market!.id,
      'created_at': createdAt,
    };
  }
}
