import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_list/components/list_card.dart';
import 'package:shopping_list/models/list.dart';
import 'package:shopping_list/providers/lists_provder.dart';

class Lists extends StatelessWidget {
  const Lists({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final listsProvider = Provider.of<ListsProvider>(context);
    return listsProvider.isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : ListView.builder(
            itemCount: listsProvider.lists.length,
            itemBuilder: (BuildContext context, int i) {
              final ListModel list = listsProvider.lists[i];
              return ListCard(
                date: list.createdAt,
                image: "",
                title: list.name,
              );
            },
          );
  }
}
