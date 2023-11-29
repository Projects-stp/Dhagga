import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:threads_clone/utils/helper.dart';

class ThreadController extends GetxController {
  final TextEditingController textEditingController =
      TextEditingController(text: "");

  var content = "".obs;
  var loading = false.obs;

  Rx<File?> image = Rx<File?>(null);

  //??
  void pickImage() async {
    File? file = await pickImageFromGallary();
    if (file != null) {
      image.value = file;
    }
  }

  @override
  void onClose() {
    textEditingController.dispose();
    super.onClose();
  }
}
