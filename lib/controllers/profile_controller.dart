import 'dart:io';

import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:threads_clone/models/reply_model.dart';
import 'package:threads_clone/service/supabase_service.dart';
import 'package:threads_clone/utils/env.dart';
import 'package:threads_clone/utils/helper.dart';

import '../models/post_model.dart';

class ProfileController extends GetxController {
  var loading = false.obs;
  Rx<File?> image = Rx<File?>(null);

  RxList<PostModel> posts = RxList<PostModel>();
  var postLoading = false.obs;

  RxList<ReplyModel> replies = RxList<ReplyModel>();
  var replyLoading = false.obs;

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

  //?? Pick image ->
  void pickImage() async {
    File? file = await pickImageFromGallary();
    if (file != null) image.value = file;
  }

  //?? fetch post ->
  void fetchUserThreads(String userId) async {
    try {
      postLoading.value = true;
      final List<dynamic> response =
          await SupabaseService.client.from("posts").select('''
    id ,content , image ,created_at ,comment_count,like_count,user_id,
    user:user_id (email , metadata), likes:likes (user_id ,post_id)
''').eq("user_id", userId).order("id", ascending: false);
      postLoading.value = false;
      if (response.isNotEmpty) {
        posts.value = [for (var item in response) PostModel.fromJson(item)];
      }
    } catch (e) {
      postLoading.value = false;
      showSnackBar('Error', 'Something went wrong');
    }
  }

  //?? fetch comments ->
  void fetchReplies(String userId) async {
    try {
      replyLoading.value = true;
      final List<dynamic> response =
          await SupabaseService.client.from("comments").select('''
    id , user_id , post_id ,reply ,created_at ,user:user_id (email , metadata)
''').eq("user_id", userId).order("id", ascending: false);
      replyLoading.value = false;
      if (response.isNotEmpty) {
        replies.value = [for (var item in response) ReplyModel.fromJson(item)];
      }
    } catch (e) {
      replyLoading.value = false;
      showSnackBar('Error', 'Something went wrong');
    }
  }
}
