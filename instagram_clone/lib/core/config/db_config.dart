import 'package:instagram_clone/core/config/environment.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

class DbConfig {
  static Future<void> init() async {
    await Supabase.initialize(
      url: Environment.supabaseUrl,
      anonKey: Environment.supabaseAnonKey,
    );
  }
}
