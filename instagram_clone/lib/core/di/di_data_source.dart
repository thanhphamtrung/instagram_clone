import 'package:get_it/get_it.dart';

import 'package:instagram_clone/core/network/api_client.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DiDataSource {
  static Future<void> registerDataSources(GetIt di) async {
    di
      ..registerSingleton<ApiClient>(ApiClient())
      ..registerSingleton<SupabaseClient>(Supabase.instance.client);
  }
}
