import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:threads_clone/controllers/notification_controller.dart';
import 'package:threads_clone/service/navigation_service.dart';
import 'package:threads_clone/service/supabase_service.dart';

import '../../routes/routes_name.dart';
import '../../utils/helper.dart';
import '../../widgets/image_circle.dart';
import '../../widgets/loading.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  final NotificationController controller = Get.put(NotificationController());

  @override
  void initState() {
    controller
        .fetchNotifications(Get.find<SupabaseService>().currentUser.value!.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.find<NavigationService>().backToPrevIndex();
          },
          icon: const Icon(Icons.close),
        ),
        title: const Text("Notification"),
      ),
      body: SingleChildScrollView(
        child: Obx(
          () => controller.loading.value
              ? const Loading()
              : Column(
                  children: [
                    if (controller.notifications.isNotEmpty)
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller.notifications.length,
                        itemBuilder: (context, index) => ListTile(
                          onTap: () {
                            Get.toNamed(
                              RouteNames.showThread,
                              arguments:
                                  controller.notifications[index].postId!,
                            );
                          },
                          titleAlignment: ListTileTitleAlignment.top,
                          isThreeLine: true,
                          leading: CircleImage(
                            url: controller
                                .notifications[index].user!.metadata?.image,
                          ),
                          title: Text(
                            controller
                                .notifications[index].user!.metadata!.name!,
                          ),
                          trailing: Text(
                            formatDateFromNow(
                              controller.notifications[index].createdAt!,
                            ),
                          ),
                          subtitle: Text(
                            controller.notifications[index].notification!,
                          ),
                        ),
                      )
                    else
                      const Text("No notifications found"),
                  ],
                ),
        ),
      ),
    );
  }
}
