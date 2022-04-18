import 'package:flutter/material.dart';
import 'package:shopping_list/config/app_config.dart';
import 'package:shopping_list/models/dropdown_option.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final String tableName = '${AppConfig.tablePrefix}markets';

class MarketsProvider extends ChangeNotifier {
  final SupabaseClient _client = AppConfig.client;
  List<DropdownOption> markets = [];

  Future<void> getMarkets() async {
    final response = await _client.from(tableName).select('*').execute();
    if (response.error == null) {
      final results = response.data as List<dynamic>;
      markets = results
          .map((e) => DropdownOption(key: e['id'], value: e['name']))
          .toList();
      notifyListeners();
    }
  }
}
