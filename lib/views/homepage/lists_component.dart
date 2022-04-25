import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_list/components/list_card.dart';
import 'package:shopping_list/components/loaders/lists_shimmer.dart';
import 'package:shopping_list/models/list.dart';
import 'package:shopping_list/providers/lists_provider.dart';

class Lists extends StatelessWidget {
  const Lists({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final listsProvider = Provider.of<ListsProvider>(context);
    return listsProvider.isLoading
        ? const ListsShimmer(count: 8)
        : listsProvider.lists.isEmpty
            ? const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Non ci sono liste, clicca sul + per crearne una nuova",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              )
            : Scrollbar(
                isAlwaysShown: true,
                child: ListView.builder(
                  itemCount: listsProvider.lists.length,
                  itemBuilder: (BuildContext context, int i) {
                    final ListModel list = listsProvider.lists[i];
                    return ListCard(list: list);
                  },
                ),
              );
  }
}
