import 'package:flutter/material.dart';
import 'package:shopping_list/components/button.dart';
import 'package:shopping_list/components/dropdown.dart';
import 'package:shopping_list/components/input.dart';
import 'package:shopping_list/models/dropdown_option.dart';
import 'package:shopping_list/shared/static.dart';

class AddShoppingListPopup extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final Function onSubmit;
  final TextEditingController _nameController = TextEditingController();
  int? selectedMarket;

  // Form object
  final Map<String, dynamic> form = {
    'name': null,
    'market': null,
  };

  AddShoppingListPopup({
    Key? key,
    required this.onSubmit,
  }) : super(key: key);

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
            key: _formKey,
            child: Column(
              children: <Widget>[
                Dropdown(
                  options: markets,
                  placeholder: "Seleziona un'opzione",
                  onChanged: (DropdownOption? market) {
                    selectedMarket = market?.key;
                    print(selectedMarket);
                  },
                ),
                const SizedBox(height: 8),
                Input(
                  type: 'text',
                  controller: _nameController,
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
                  if (_formKey.currentState!.validate()) {
                    form['name'] = _nameController.text;
                    form['market'] = selectedMarket;
                    onSubmit(form);
                  }
                },
              ),
            ),
          ],
        )
      ],
    );
  }
}
