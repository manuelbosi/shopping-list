import 'package:flutter/material.dart';
import 'package:shopping_list/config/app_config.dart';
import 'package:shopping_list/models/market.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final String tableName = '${AppConfig.tablePrefix}markets';

class MarketsProvider extends ChangeNotifier {
  final SupabaseClient _client = AppConfig.client;
  List<Market> markets = [];
  bool isLoading = false;

  Future<void> getMarkets() async {
    setIsLoading(true);
    final response = await _client.from(tableName).select('*').execute();
    if (response.error == null) {
      final results = response.data as List<dynamic>;
      markets = results
          .map((market) => Market(
                id: market['id'],
                name: market['name'],
                imageUrl: market['image'],
              ))
          .toList();
    }
    setIsLoading(false);
    notifyListeners();
  }

  void setIsLoading(bool v) {
    isLoading = v;
  }
}
