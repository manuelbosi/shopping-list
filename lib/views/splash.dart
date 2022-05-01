import 'package:flutter/material.dart';
import 'package:shopping_list/config/colors.dart';
import 'package:shopping_list/services/user.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkIfLogged(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: ColorPalette.primary,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset('assets/icon-no-bg.png', width: 200),
                const SizedBox(height: 32),
                const Text(
                  "Shopping list",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 40, color: Colors.white),
                ),
                const SizedBox(height: 24),
                const Text(
                  "Crea e gestisci le tue liste della spesa",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22, color: Colors.white),
                ),
                const SizedBox(height: 40),
                const CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _checkIfLogged(BuildContext context) async {
    final session = await UserService().isLogged();
    await Future.delayed(const Duration(seconds: 3));
    if (session == null) {
      Navigator.pushReplacementNamed(context, '/login');
    } else {
      UserService().recoverSession(context, session);
    }
  }
}
