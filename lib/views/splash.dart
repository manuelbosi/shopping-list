import 'package:flutter/material.dart';
import 'package:shopping_list/services/user.dart';
import 'package:shopping_list/views/auth/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkIfLogged();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.deepPurple,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Text(
                  "Shopping List",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 40, color: Colors.white),
                ),
                Text(
                  "Crea e gestisci le tue liste della spesa",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25),
                ),
                SizedBox(height: 20),
                CircularProgressIndicator(
                  color: Colors.white,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _checkIfLogged() async {
    final session = await UserService().isLogged();
    await Future.delayed(const Duration(seconds: 3));
    if (session == null) {
      Navigator.pushReplacementNamed(context, '/login', result: LoginPage());
    } else {
      UserService().recoverSession(session);
      Navigator.pushReplacementNamed(context, '/home');
    }
  }
}
