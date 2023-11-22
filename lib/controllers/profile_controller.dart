import 'dart:io';

import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:threads_clone/service/supabase_service.dart';
import 'package:threads_clone/utils/env.dart';
import 'package:threads_clone/utils/helper.dart';

class ProfileController extends GetxController {
  var loading = false.obs;
  Rx<File?> image = Rx<File?>(null);

  //?? update profile method ->
  Future<void> updateProfile(String userId, String description) async {
    try {
      loading.value = true;
      var uploadedPath = "";
      //*** Check if image exits then upload it first
      if (image.value != null && image.value!.existsSync()) {
        final String dir = "$userId/profile.jpg";
        final String path =
            await SupabaseService.client.storage.from(Env.s3Bucket).upload(
                  dir,
                  image.value!,
                  fileOptions: const FileOptions(upsert: true),
                );
        uploadedPath = path;

        //?? update profile ->
        await SupabaseService.client.auth.updateUser(
          UserAttributes(
            data: {
              "description": description,
              "image": uploadedPath.isNotEmpty ? uploadedPath : null,
            },
          ),
        );
      }

      // await SupabaseService.client.auth.updateUser(
      //   UserAttributes(
      //     data: {
      //       "description": description,
      //     },
      //   ),
      // );

      loading.value = false;
      Get.back();
      showSnackBar("Success", "Profile update successfully!");
    } on AuthException catch (error) {
      loading.value = false;
      showSnackBar("Error", error.message);
    } on StorageException catch (error) {
      loading.value = false;
      showSnackBar("Error", error.message);
    }
  }

  //*** Pick image ->
  void pickImage() async {
    File? file = await pickImageFromGallary();
    if (file != null) image.value = file;
  }
}
