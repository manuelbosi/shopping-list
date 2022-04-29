import 'package:flutter/material.dart';
import 'package:shopping_list/config/app_config.dart';
import 'package:shopping_list/models/products.dart';
import 'package:shopping_list/utils/custom_snackbar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final String tableName = '${AppConfig.tablePrefix}products';

class ProductsProvider extends ChangeNotifier {
  final _client = AppConfig.client;
  bool isLoading = false;
  List<Product> products = [];
  Map<SupabaseEventTypes, RealtimeSubscription?> subscriptions = {
    SupabaseEventTypes.insert: null,
    SupabaseEventTypes.update: null,
    SupabaseEventTypes.delete: null,
  };

  Future<void> getProducts([int? listId]) async {
    isLoading = true;
    products = [];
    final response = await _client
        .from('sl_products')
        .select('*')
        .eq('list_id', listId)
        .execute();
    if (response.error == null) {
      final results = response.data as List<dynamic>;
      products = results.map((e) => Product.fromJson(e)).toList();
    }
    isLoading = false;
    notifyListeners();
  }

  // Setup realtime subscription
  void setupSubscriptions(int listId) {
    _setupInsertSubscription(listId);
    _setupUpdateSubscription();
    _setupDeleteSubscription();
  }

  /// Dispose subscription
  void disposeSubscription() {
    subscriptions[SupabaseEventTypes.insert]!.unsubscribe();
    subscriptions[SupabaseEventTypes.update]!.unsubscribe();
    subscriptions[SupabaseEventTypes.delete]!.unsubscribe();
  }

  void _setupInsertSubscription(int listId) {
    subscriptions[SupabaseEventTypes.insert] =
        _client.from(tableName).on(SupabaseEventTypes.insert, (payload) {
      if (listId == payload.newRecord!['list_id']) {
        final newProduct = Product.fromJson(payload.newRecord);
        products = [newProduct, ...products];
        notifyListeners();
      }
    }).subscribe();
  }

  void _setupUpdateSubscription() {
    subscriptions[SupabaseEventTypes.update] =
        _client.from(tableName).on(SupabaseEventTypes.update, (payload) {
      final updatedProduct = payload.newRecord;
      final int productIndex = products
          .indexWhere((Product product) => product.id == updatedProduct!['id']);
      products.removeWhere(
          (Product product) => product.id == payload.newRecord!['id']);
      final newProduct = Product.fromJson(updatedProduct);
      products.insert(productIndex, newProduct);
      notifyListeners();
    }).subscribe();
  }

  void _setupDeleteSubscription() {
    subscriptions[SupabaseEventTypes.delete] =
        _client.from(tableName).on(SupabaseEventTypes.delete, (payload) {
      products.removeWhere(
          (Product product) => product.id == payload.oldRecord!['id']);
      notifyListeners();
    }).subscribe();
  }

  Future<void> updateProductState(Product product, bool isAdded) async {
    await _client
        .from(tableName)
        .update({'is_added': isAdded})
        .eq('id', product.id)
        .execute();
  }

  Future<void> addProduct(
      Map<String, dynamic> product, BuildContext context) async {
    final response = await _client.from(tableName).insert(product).execute();
    if (response.error == null) {
      CustomSnackBar.showSuccess(
          context: context, message: "Prodotto inserito");
      Navigator.pop(context);
    }
  }

  Future<void> deleteProduct(Product product) async {
    final response =
        await _client.from(tableName).delete().eq('id', product.id).execute();
    if (response.error == null) {
      products.removeWhere((Product p) => p.id == product.id);
      notifyListeners();
    } else {
      print("error");
    }
  }
}
