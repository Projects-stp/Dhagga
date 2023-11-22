import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:threads_clone/controllers/profile_controller.dart';
import 'package:threads_clone/service/supabase_service.dart';
import 'package:threads_clone/widgets/image_circle.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  //??
  final TextEditingController textEditingController =
      TextEditingController(text: "");
  final ProfileController controller = Get.find<ProfileController>();
  final SupabaseService supabaseService = Get.find<SupabaseService>();

  //??
  @override
  void initState() {
    textEditingController.text =
        supabaseService.currentUser.value?.userMetadata?["description"] ?? "";
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        actions: [
          Obx(
            () => TextButton(
              onPressed: () {
                controller.updateProfile(
                  supabaseService.currentUser.value!.id,
                  textEditingController.text,
                );
              },
              child: controller.loading.value
                  ? const SizedBox(
                      height: 14,
                      width: 14,
                      child: CircularProgressIndicator.adaptive(),
                    )
                  : const Text('Done'),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Obx(
              () => Stack(
                alignment: Alignment.topRight,
                children: [
                  CircleImage(
                    radius: 80.0,
                    path: controller.image.value,
                    url: supabaseService
                        .currentUser.value?.userMetadata?["image"],
                  ),
                  IconButton(
                    onPressed: () {
                      controller.pickImage();
                    },
                    icon: const CircleAvatar(
                      radius: 20.0,
                      backgroundColor: Colors.white70,
                      child: Icon(Icons.edit),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            TextFormField(
              controller: textEditingController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                hintText: 'Your Description',
                label: Text('Description'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
