import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:threads_clone/controllers/thread_controller.dart';
import 'package:threads_clone/service/supabase_service.dart';
import 'package:threads_clone/widgets/add_thread_appbar.dart';
import 'package:threads_clone/widgets/image_circle.dart';
import 'package:threads_clone/widgets/thread_image_preview.dart';

class AddThreads extends StatelessWidget {
  AddThreads({super.key});

  //??
  final SupabaseService supabaseService = Get.find<SupabaseService>();
  final ThreadController controller = Get.put(ThreadController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const AddThreadAppBar(),
              const SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(
                    () => CircleImage(
                      url: supabaseService
                          .currentUser.value!.userMetadata?["image"],
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  SizedBox(
                    width: context.width * 0.80,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(
                          () => Text(
                            supabaseService
                                .currentUser.value!.userMetadata?["name"],
                          ),
                        ),
                        TextField(
                          autofocus: true,
                          controller: controller.textEditingController,
                          onChanged: (value) =>
                              controller.content.value = value,
                          style: const TextStyle(fontSize: 15.0),
                          maxLines: 10,
                          minLines: 1,
                          maxLength: 1000,
                          decoration: const InputDecoration(
                            hintText: 'type a thread',
                            border: InputBorder.none,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => controller.pickImage(),
                          child: const Icon(Icons.attach_file),
                        ),

                        //?? to see image
                        Obx(
                          () => Column(
                            children: [
                              if (controller.image.value != null)
                                ThreadImagePreview(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
