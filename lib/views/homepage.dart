import 'package:flutter/material.dart';
import 'package:shopping_list/services/user.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shopping List"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            user != null ? Text("${user!.email}") : Container(),
            ElevatedButton(
                onPressed: () {
                  UserService().logout(context);
                },
                child: const Text("LOGOUT"))
          ],
        ),
      ),
    );
  }
}
