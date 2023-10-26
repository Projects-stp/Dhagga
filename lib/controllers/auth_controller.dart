import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:threads_clone/routes/routes_name.dart';
import 'package:threads_clone/service/storage_service.dart';
import 'package:threads_clone/utils/helper.dart';

import '../service/supabase_service.dart';
import '../utils/storage_key.dart';

class AuthController extends GetxController {
  final registerLoading = false.obs;
  final loginLoading = false.obs;

  //?? Register Method ->
  Future<void> register(String name, String email, String password) async {
    try {
      registerLoading.value = true;
      final AuthResponse response = await SupabaseService.client.auth.signUp(
        email: email,
        password: password,
        data: {"name": name},
      );
      registerLoading.value = false;

      if (response.user != null) {
        StorageService.session
            .write(StorageKey.userSession, response.session!.toJson());
        Get.offAllNamed(RouteNames.home);
      }
    } on AuthException catch (error) {
      registerLoading.value = false;
      showSnackBar('Error', error.message);
    }
  }

  //?? Login Method ->
  Future<void> login(String email, String password) async {
    loginLoading.value = true;
    try {
      final AuthResponse response = await SupabaseService.client.auth
          .signInWithPassword(email: email, password: password);
      loginLoading.value = false;
      if (response.user != null) {
        StorageService.session
            .write(StorageKey.userSession, response.session!.toJson());
        Get.offAllNamed(RouteNames.home);
      }
    } on AuthException catch (error) {
      loginLoading.value = false;
      showSnackBar("Error", error.message);
    }
  }
}
