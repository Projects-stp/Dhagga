import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:threads_clone/utils/helper.dart';

import '../service/supabase_service.dart';

class ReplyController extends GetxController {
  final TextEditingController replyController = TextEditingController(text: '');
  var reply = "".obs;
  var loading = false.obs;

  //??
  @override
  void onClose() {
    replyController.dispose();
    super.onClose();
  }

  //??
  void addReply(String userId, int postId, String postUserId) async {
    try {
      loading.value = true;

      //?? Increase the post comment count ->
      await SupabaseService.client.rpc(
        "comment_increment",
        params: {
          "count": 1,
          "row_id": postId,
        },
      );

      //?? Add Comment notification ->
      await SupabaseService.client.from("notifications").insert(
        {
          "user_id": userId,
          "notification": "commented on your post.",
          "to_user_id": postUserId,
          "post_id": postId,
        },
      );

      //?? Add comment in supabase ->
      await SupabaseService.client.from("comments").insert(
        {
          "post_id": postId,
          "user_id": userId,
          "reply": replyController.text,
        },
      );
      loading.value = false;
      Get.back();
      showSnackBar("Success", "Replied successfully!");
    } catch (e) {
      loading.value = false;
      showSnackBar("Error", "Something went wrong.please try again!");
    }
  }
}
