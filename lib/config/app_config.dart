import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AppConfig {
  // Supabase client
  static final SupabaseClient client = SupabaseClient(
    dotenv.get('SUPABASE_URL'),
    dotenv.get('SUPABASE_KEY'),
  );
  static const String tablePrefix = 'sl_';
}
