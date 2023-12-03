import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:threads_clone/models/reply_model.dart';
import 'package:threads_clone/service/navigation_service.dart';
import 'package:threads_clone/service/supabase_service.dart';
import 'package:threads_clone/utils/env.dart';
import 'package:threads_clone/utils/helper.dart';
import 'package:uuid/uuid.dart';

import '../models/post_model.dart';

class ThreadController extends GetxController {
  final TextEditingController textEditingController =
      TextEditingController(text: "");

  var content = "".obs;
  var loading = false.obs;

  Rx<File?> image = Rx<File?>(null);

  var showThreadLoading = false.obs;
  Rx<PostModel> post = Rx<PostModel>(PostModel());

  var replyLoading = false.obs;
  RxList<ReplyModel> replies = RxList<ReplyModel>();

  //??
  void pickImage() async {
    File? file = await pickImageFromGallary();
    if (file != null) {
      image.value = file;
    }
  }

  //??
  void store(String userId) async {
    try {
      loading.value = true;
      const uuid = Uuid();
      final dir = "$userId/${uuid.v6()}";
      var imgPath = "";

      if (image.value != null && image.value!.existsSync()) {
        imgPath = await SupabaseService.client.storage
            .from(Env.s3Bucket)
            .upload(dir, image.value!);
      }

      //*** Store post in table
      await SupabaseService.client.from("posts").insert({
        "user_id": userId,
        "content": content.value,
        "image": imgPath.isNotEmpty ? imgPath : null,
      });
      loading.value = false;
      resetState();
      Get.find<NavigationService>().currentIndex.value = 0;

      showSnackBar("Success", "Post Added successfully!");
    } on StorageException catch (error) {
      loading.value = false;
      showSnackBar("Error", error.message);
    } catch (error) {
      loading.value = false;
      showSnackBar("Error", "Something went wrong!");
    }
  }

  //??
  void show(int postId) async {
    try {
      post.value = PostModel();
      replies.value = [];
      showThreadLoading.value = true;
      final data = await SupabaseService.client.from("posts").select('''
    id ,content , image ,created_at ,comment_count , like_count,user_id,
    user:user_id (email , metadata),likes:likes (user_id ,post_id)
''').eq("id", postId).single();

      showThreadLoading.value = false;
      post.value = PostModel.fromJson(data);

      //*** Load post comments
      fetchPostReplies(postId);
    } catch (e) {
      showThreadLoading.value = false;
      showSnackBar("Error", "Something went wrong!");
    }
  }

  //??
  void fetchPostReplies(int postId) async {
    try {
      replyLoading.value = true;
      final List<dynamic> data =
          await SupabaseService.client.from("comments").select('''
    id ,reply ,created_at ,user_id,
    user:user_id (email , metadata)
''').eq("post_id", postId);

      replyLoading.value = false;

      if (data.isNotEmpty) {
        replies.value = [for (var item in data) ReplyModel.fromJson(item)];
      }
    } catch (e) {
      replyLoading.value = false;
      showSnackBar("Error", "Something went wrong!");
    }
  }

  //??
  Future<void> likeDislike(
    String status,
    int postId,
    String postUserId,
    String userId,
  ) async {
    if (status == "1") {
      await SupabaseService.client.from("likes").insert(
        {
          "user_id": userId,
          "post_id": postId,
        },
      );

      //?? Add Comment notification
      await SupabaseService.client.from("notifications").insert(
        {
          "user_id": userId,
          "notification": "liked on your post.",
          "to_user_id": postUserId,
          "post_id": postId,
        },
      );

      //?? Increment like counter in post table
      await SupabaseService.client.rpc(
        "like_increment",
        params: {
          "count": 1,
          "row_id": postId,
        },
      );
    } else if (status == "0") {
      await SupabaseService.client.from("likes").delete().match(
        {
          "user_id": userId,
          "post_id": postId,
        },
      );

      //?? Decrement like counter in post table
      await SupabaseService.client.rpc(
        "like_decrement",
        params: {
          "count": 1,
          "row_id": postId,
        },
      );
    }
  }

  //??
  void resetState() {
    content.value = "";
    textEditingController.text = "";
    image.value = null;
  }

  @override
  void onClose() {
    textEditingController.dispose();
    super.onClose();
  }
}
