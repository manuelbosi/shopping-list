import 'package:flutter/material.dart';
import 'package:shopping_list/components/button.dart';
import 'package:shopping_list/components/input.dart';
import 'package:shopping_list/config/colors.dart';
import 'package:shopping_list/models/products.dart';

class AddProductSheet extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final Function(Map<String, dynamic> product) onSubmit;
  final TextEditingController _nameController = TextEditingController();
  final int listId;

  AddProductSheet({
    Key? key,
    required this.onSubmit,
    required this.listId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.only(
            top: 20,
            left: 16,
            right: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Inserisci un prodotto e premi il tasto Salva",
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 16),
              Input(
                type: 'text',
                controller: _nameController,
                isRequired: true,
                minLength: 2,
                placeholder: "Nome prodotto",
              ),
              Button(
                type: 'success',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final newProduct = Product(
                            name: _nameController.text,
                            listId: listId,
                            isAdded: false,
                            createdAt: DateTime.now().toString())
                        .toJson();
                    onSubmit(newProduct);
                  }
                },
                child: const Text("SALVA"),
                width: double.infinity,
              )
            ],
          ),
        ),
      ),
    );
  }
}
