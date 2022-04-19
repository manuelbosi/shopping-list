import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_list/components/button.dart';
import 'package:shopping_list/components/dropdown.dart';
import 'package:shopping_list/components/input.dart';
import 'package:shopping_list/models/dropdown_option.dart';
import 'package:shopping_list/models/list.dart';
import 'package:shopping_list/providers/markets_provider.dart';

class AddShoppingListPopup extends StatefulWidget {
  final _formKey = GlobalKey<FormState>();
  final Function(Map<String, dynamic> list) onSubmit;
  final TextEditingController _nameController = TextEditingController();

  AddShoppingListPopup({
    Key? key,
    required this.onSubmit(Map<String, dynamic> list),
  }) : super(key: key);

  @override
  State<AddShoppingListPopup> createState() => _AddShoppingListPopupState();
}

class _AddShoppingListPopupState extends State<AddShoppingListPopup> {
  int? _selectedMarket;
  // Form object

  @override
  void initState() {
    super.initState();
    _getMarkets();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 5,
      title: const Text("Crea lista"),
      titlePadding: const EdgeInsets.all(16.0),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Form(
            key: widget._formKey,
            child: Column(
              children: <Widget>[
                Dropdown(
                  // options: _marketsDropdown,
                  options: Provider.of<MarketsProvider>(context, listen: true)
                      .markets,
                  placeholder: "Seleziona un'opzione",
                  onChanged: (DropdownOption? market) {
                    _selectedMarket = market?.key;
                  },
                ),
                const SizedBox(height: 8),
                Input(
                  type: 'text',
                  controller: widget._nameController,
                  isRequired: true,
                  placeholder: "Nome lista",
                ),
              ],
            ),
          )
        ],
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
      actionsPadding: const EdgeInsets.symmetric(horizontal: 8.0),
      actions: [
        Row(
          children: [
            Expanded(
              child: Button(
                type: 'danger',
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Annulla"),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Button(
                type: 'success',
                child: const Text("Salva"),
                onPressed: () {
                  if (widget._formKey.currentState!.validate()) {
                    final Map<String, dynamic> newList = ListModel(
                      name: widget._nameController.text,
                      marketId: _selectedMarket!,
                      isCompleted: false,
                      createdAt: DateTime.now().toString(),
                    ).toJson();
                    widget.onSubmit(newList);
                  }
                },
              ),
            ),
          ],
        )
      ],
    );
  }

  void _getMarkets() async {
    await Provider.of<MarketsProvider>(context, listen: false).getMarkets();
  }
}
