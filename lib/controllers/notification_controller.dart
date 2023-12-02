import 'package:get/get.dart';
import 'package:threads_clone/utils/helper.dart';

import '../models/notification_model.dart';
import '../service/supabase_service.dart';

class NotificationController extends GetxController {
  RxList<NotificationModel> notifications = RxList<NotificationModel>();
  var loading = false.obs;

  void fetchNotifications(String userId) async {
    try {
      loading.value = true;
      final List<dynamic> response =
          await SupabaseService.client.from("notifications").select('''
  id, post_id, notification,created_at , user_id ,user:user_id (email , metadata)
''').eq("to_user_id", userId).order("id", ascending: false);

      loading.value = false;

      if (response.isNotEmpty) {
        notifications.value = [
          for (var item in response) NotificationModel.fromJson(item)
        ];
      }
    } catch (e) {
      loading.value = false;
      showSnackBar('Error', 'Something went wrong!');
    }
  }
}
