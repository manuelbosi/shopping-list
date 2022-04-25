import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_list/components/product_item.dart';
import 'package:shopping_list/config/colors.dart';
import 'package:shopping_list/models/products.dart';
import 'package:shopping_list/providers/products_provider.dart';

class ProductsList extends StatefulWidget {
  final Map<String, dynamic> params;
  const ProductsList(this.params, {Key? key}) : super(key: key);

  @override
  State<ProductsList> createState() => _ProductsListState();
}

class _ProductsListState extends State<ProductsList> {
  @override
  void initState() {
    super.initState();
    _fetchProducts();
    _setupSubscriptions();
  }

  @override
  void deactivate() {
    super.deactivate();
    _disposeSubscriptions();
  }

  @override
  Widget build(BuildContext context) {
    final ProductsProvider productsProvider =
        Provider.of<ProductsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Prodotti"),
        backgroundColor: ColorPalette.primary,
      ),
      body: productsProvider.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.separated(
              separatorBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  height: 1,
                  color: ColorPalette.purple,
                ),
              ),
              itemCount: productsProvider.products.length,
              itemBuilder: (context, int i) {
                final Product product = productsProvider.products[i];
                final Key key = Key("product-${product.id}");
                return ProductItem(key: key, product: product);
              },
            ),
    );
  }

  void _fetchProducts() async {
    await Provider.of<ProductsProvider>(context, listen: false)
        .getProducts(widget.params['id']);
  }

  void _setupSubscriptions() {
    Provider.of<ProductsProvider>(context, listen: false)
        .setupSubscriptions(widget.params['id']);
  }

  void _disposeSubscriptions() {
    Provider.of<ProductsProvider>(context, listen: false).disposeSubscription();
  }
}