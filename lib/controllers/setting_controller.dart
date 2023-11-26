import 'package:get/get.dart';
import 'package:threads_clone/routes/routes_name.dart';
import 'package:threads_clone/service/storage_service.dart';
import 'package:threads_clone/service/supabase_service.dart';
import 'package:threads_clone/utils/storage_key.dart';

class SettingController extends GetxController {
  void logout() async {
    StorageService.session.remove(StorageKey.userSession);
    await SupabaseService.client.auth.signOut();

    Get.offAllNamed(RouteNames.login);
  }
}
