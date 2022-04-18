import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_list/config/app_config.dart';
import 'package:shopping_list/config/storage_keys.dart';
import 'package:shopping_list/utils/custom_snackbar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserService {
  // Get supabase client
  final SupabaseClient client = AppConfig.client;

  // User registration
  Future<void> register(context, {String? email, String? password}) async {
    final result = await client.auth.signUp(email!, password!);
    if (result.data != null) {
      // Navigator.pushReplacementNamed(context, '/login');
      Navigator.of(context).pushReplacementNamed('/login');
    } else if (result.error?.message != null) {
      CustomSnackBar.showError(
          context: context, message: result.error!.message);
    }
  }

  // User login
  Future<void> login(context, {String? email, String? password}) async {
    final prefs = await SharedPreferences.getInstance();
    final result = await client.auth.signIn(email: email, password: password);
    if (result.data != null) {
      await prefs.setString('USER', result.data!.persistSessionString);
      Navigator.of(context).pushReplacementNamed('/home');
    } else if (result.error?.message != null) {
      CustomSnackBar.showError(
          context: context, message: result.error!.message);
    }
  }

  // User logout
  Future<void> logout(context, {String? email, String? password}) async {
    final prefs = await SharedPreferences.getInstance();
    await client.auth.signOut();
    await prefs.remove(StorageKeys.USER_SESSION);
    Navigator.of(context).pushReplacementNamed('/login');
  }

  // Get current user
  User? getLoggedUser() {
    return client.auth.user();
  }

  // Recover session
  Future<void> recoverSession(BuildContext context, session) async {
    final prefs = await SharedPreferences.getInstance();
    final response = await client.auth.recoverSession(session);
    if (response.data != null) {
      prefs.setString(
          StorageKeys.USER_SESSION, response.data!.persistSessionString);
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      Navigator.pushReplacementNamed(context, '/login');
      CustomSnackBar.showError(context: context, message: "Sessione scaduta");
    }
  }

  /// Check if the user is already logged, returns null or the user session
  Future<dynamic> isLogged() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final session = sharedPreferences.getString(StorageKeys.USER_SESSION);
    return session;
  }
}
