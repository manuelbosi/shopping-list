import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:shopping_list/providers/lists_provder.dart';
import 'package:shopping_list/views/auth/login.dart';
import 'package:shopping_list/views/auth/register.dart';
import 'package:shopping_list/views/homepage/homepage.dart';
import 'package:shopping_list/views/splash.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ListsProvider(),
        )
      ],
      child: const App(),
    ),
  );
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
    );
  }
}
