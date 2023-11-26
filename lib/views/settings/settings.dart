import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:threads_clone/controllers/setting_controller.dart';
import 'package:threads_clone/utils/helper.dart';

class Setting extends StatelessWidget {
  Setting({super.key});
  final SettingController controller = Get.put(SettingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Logout"),
              onTap: () {
                confirmDialog(
                  "Are you sure?",
                  "This action will log you out from the app!!",
                  controller.logout,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
