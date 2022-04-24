import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_list/components/add_list_popup.dart';
import 'package:shopping_list/config/colors.dart';
import 'package:shopping_list/providers/lists_provider.dart';
import 'package:shopping_list/services/user.dart';
import 'package:shopping_list/views/homepage/lists_component.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide Provider;

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final User? user = UserService().getLoggedUser();

  @override
  void initState() {
    super.initState();
    _fetchData();
    _setupSubscriptions();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Elenco liste"),
        backgroundColor: ColorPalette.primary,
      ),
      body: const Lists(),
      drawer: Drawer(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Ciao,\n${user!.email}",
                  style: const TextStyle(
                    fontSize: 28,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: LayoutBuilder(
            builder: ((context, constraints) =>
                Icon(Icons.add, size: constraints.maxHeight / 2))),
        onPressed: () {
          _showAddListPopup();
        },
        backgroundColor: ColorPalette.primary,
        splashColor: Colors.transparent,
        elevation: 0,
        focusElevation: 0,
        highlightElevation: 0,
        hoverElevation: 0,
        disabledElevation: 0,
      ),
    );
  }

  void _fetchData() async {
    await Provider.of<ListsProvider>(context, listen: false).getLists();
  }

  void _setupSubscriptions() {
    Provider.of<ListsProvider>(context, listen: false).setupSubscriptions();
  }

  void _showAddListPopup() {
    showDialog(
      context: context,
      builder: (context) {
        return AddShoppingListPopup(
          onSubmit: (Map<String, dynamic> newList) async {
            await Provider.of<ListsProvider>(context, listen: false)
                .createList(newList, context);
          },
        );
      },
    );
  }
}
