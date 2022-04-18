import 'package:flutter/material.dart';
import 'package:shopping_list/config/app_config.dart';
import 'package:shopping_list/models/list.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final String tableName = '${AppConfig.tablePrefix}lists';

class ListsProvider extends ChangeNotifier {
  final _client = AppConfig.client;
  bool _isLoading = false;
  List<ListModel> lists = [];

  Map<String, RealtimeSubscription?> subscriptions = {
    'insert': null,
    'update': null,
    'delete': null,
  };

  Future<void> getLists() async {
    _setLoadingState(true);
    final response = await _client
        .from(tableName)
        .select('*')
        .order('created_at', ascending: false)
        .execute();
    if (response.error == null) {
      final results = response.data as List<dynamic>;
      lists = results.map((e) => ListModel.fromJson(e)).toList();
    }
    _setLoadingState(false);
    notifyListeners();
  }

  bool get isLoading => _isLoading;
  void _setLoadingState(bool isLoading) => _isLoading = isLoading;

  // Setup realtime subscription
  void setupSubscription() {
    _setupInsertSubscription();
    _setupUpdateSubscription();
    _setupDeleteSubscription();
  }

  void _setupInsertSubscription() {
    subscriptions['insert'] =
        _client.from(tableName).on(SupabaseEventTypes.insert, (payload) {
      final newList = ListModel.fromJson(payload.newRecord);
      lists = [newList, ...lists];
      notifyListeners();
    }).subscribe();
  }

  void _setupUpdateSubscription() {
    subscriptions['update'] =
        _client.from(tableName).on(SupabaseEventTypes.update, (payload) {
      lists
          .removeWhere((ListModel list) => list.id == payload.oldRecord!['id']);
      final newList = ListModel.fromJson(payload.newRecord);
      lists = [newList, ...lists];
      notifyListeners();
    }).subscribe();
  }

  void _setupDeleteSubscription() {
    subscriptions['delete'] =
        _client.from(tableName).on(SupabaseEventTypes.delete, (payload) {
      lists
          .removeWhere((ListModel list) => list.id == payload.oldRecord!['id']);
      notifyListeners();
    }).subscribe();
  }
}
