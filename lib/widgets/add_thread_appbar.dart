import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:threads_clone/controllers/thread_controller.dart';
import 'package:threads_clone/service/navigation_service.dart';
import 'package:threads_clone/service/supabase_service.dart';

class AddThreadAppBar extends StatelessWidget {
  AddThreadAppBar({super.key});

  final ThreadController controller = Get.find<ThreadController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xff242424),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  Get.find<NavigationService>().backToPrevIndex();
                },
                icon: const Icon(Icons.close),
              ),
              const SizedBox(width: 10.0),
              const Text(
                "New Thread",
                style: TextStyle(fontSize: 20.0),
              ),
            ],
          ),
          Obx(
            () => TextButton(
              onPressed: () {
                if (controller.content.value.isNotEmpty) {
                  controller
                      .store(Get.find<SupabaseService>().currentUser.value!.id);
                }
              },
              child: controller.loading.value
                  ? const SizedBox(
                      height: 16.0,
                      width: 16.0,
                      child: CircularProgressIndicator.adaptive(),
                    )
                  : Text(
                      "Post",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: controller.content.value.isNotEmpty
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
