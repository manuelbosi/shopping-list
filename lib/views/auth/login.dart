import 'package:flutter/material.dart';
import 'package:shopping_list/components/input.dart';
import 'package:shopping_list/services/user.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Form(
            key: _formKey,
            child: LayoutBuilder(builder: (context, constraints) {
              return SizedBox(
                width: constraints.maxWidth - 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Input(
                      type: 'text',
                      controller: _emailController,
                      label: "Email",
                      placeholder: "Indirizzo email",
                      icon: Icons.person_rounded,
                      isRequired: true,
                    ),
                    const SizedBox(height: 16),
                    Input(
                      type: 'text',
                      controller: _passwordController,
                      placeholder: "Password",
                      icon: Icons.lock,
                      isRequired: true,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: const ButtonStyle(
                          alignment: Alignment.center,
                          splashFactory: NoSplash.splashFactory,
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await UserService().login(
                              context,
                              email: _emailController.text,
                              password: _passwordController.text,
                            );
                          }
                        },
                        child: const Text("Accedi"),
                      ),
                    ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushReplacementNamed('/register');
                      },
                      child: const Text(
                        "Non sei registrato? Clicca qui per creare un account",
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
