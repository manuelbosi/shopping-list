import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shopping_list/views/auth/login.dart';
import 'package:shopping_list/views/auth/register.dart';
import 'package:shopping_list/views/homepage.dart';
import 'package:shopping_list/views/splash.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  await Supabase.initialize(debug: true);
  await dotenv.load(fileName: ".env");
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/register': ((context) => RegisterPage()),
        '/login': (context) => LoginPage(),
        '/home': ((context) => Homepage())
      },
      onGenerateRoute: (settings) {
        print(settings);
        if (settings.name == "/") {
          return PageRouteBuilder(
            settings: settings,
            pageBuilder: (_, __, ___) => LoginPage(),
            transitionsBuilder: (_, a, __, c) {
              return FadeTransition(opacity: a, child: c);
            },
          );
        }
        return null;
      },
    );
  }
}
