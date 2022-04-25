import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_list/components/checkbox.dart';
import 'package:shopping_list/models/products.dart';
import 'package:shopping_list/providers/products_provider.dart';

class ProductItem extends StatefulWidget {
  final Product product;
  const ProductItem({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  late bool _isChecked;

  @override
  void initState() {
    super.initState();
    _isChecked = widget.product.isAdded;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        widget.product.name.toUpperCase(),
        style: TextStyle(
          decoration:
              _isChecked ? TextDecoration.lineThrough : TextDecoration.none,
        ),
      ),
      trailing: InputCheckbox(
        onChange: (bool v) {
          Provider.of<ProductsProvider>(context, listen: false)
              .updateProductState(widget.product, v);
          setState(() => _isChecked = v);
        },
        isChecked: _isChecked,
        size: 20,
      ),
    );
  }
}
