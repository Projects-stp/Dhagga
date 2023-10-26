import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:threads_clone/utils/env.dart';

class SupabaseService extends GetxService {
  //??
  @override
  void onInit() async {
    await Supabase.initialize(url: Env.supabaseUrl, anonKey: Env.supabaseKey);
    super.onInit();
  }

  static final SupabaseClient client = Supabase.instance.client;
}
