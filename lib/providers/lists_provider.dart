import 'package:flutter/material.dart';
import 'package:shopping_list/config/app_config.dart';
import 'package:shopping_list/models/list.dart';
import 'package:shopping_list/models/market.dart';
import 'package:shopping_list/requests/lists_request.dart';
import 'package:shopping_list/utils/custom_snackbar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final String tableName = '${AppConfig.tablePrefix}lists';

class ListsProvider extends ChangeNotifier {
  final _client = AppConfig.client;
  bool _isLoading = false;
  List<ListModel> lists = [];

  Map<SupabaseEventTypes, RealtimeSubscription?> subscriptions = {
    SupabaseEventTypes.insert: null,
    SupabaseEventTypes.delete: null,
  };

  Future<void> getLists() async {
    _setLoadingState(true);
    final String query = allListsRequest();
    final response = await _client
        .from(tableName)
        .select(query)
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
  void setupSubscriptions() {
    _setupInsertSubscription();
    _setupDeleteSubscription();
  }

  void _setupInsertSubscription() {
    subscriptions[SupabaseEventTypes.insert] =
        _client.from(tableName).on(SupabaseEventTypes.insert, (payload) async {
      final newList = ListModel.fromJson(payload.newRecord, false);

      // OK: but with unhandle exception bug
      final int marketId = payload.newRecord!['market_id'];
      final market = await _client
          .from('sl_markets')
          .select()
          .eq('id', marketId)
          .limit(1)
          .single()
          .execute();
      newList.market = Market.fromJson(market.data);
      final tmpLists = [newList, ...lists];
      lists = tmpLists;
      notifyListeners();

      // TEST: debugging supabase unhandle exception
      // newList.market = const Market(
      //     id: 1,
      //     name: "Coop",
      //     imageUrl:"IMAGE_URL");
      // lists = [newList, ...lists];
      // notifyListeners();
    }).subscribe();
  }

  void _setupDeleteSubscription() {
    subscriptions[SupabaseEventTypes.delete] =
        _client.from(tableName).on(SupabaseEventTypes.delete, (payload) {
      lists
          .removeWhere((ListModel list) => list.id == payload.oldRecord!['id']);
      notifyListeners();
    }).subscribe();
  }

  Future<void> createList(
      Map<String, dynamic> list, BuildContext context) async {
    final response = await _client.from(tableName).insert(list).execute();
    if (response.error == null) {
      CustomSnackBar.showSuccess(context: context, message: "Lista salvata");
      Navigator.pop(context);
    }
  }
}
