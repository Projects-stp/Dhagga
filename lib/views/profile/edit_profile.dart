import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:threads_clone/controllers/profile_controller.dart';
import 'package:threads_clone/widgets/image_circle.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  //??
  final ProfileController controller = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text('Done'),
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
