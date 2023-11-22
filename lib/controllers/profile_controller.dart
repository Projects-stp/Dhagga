import 'dart:io';

import 'package:get/get.dart';
import 'package:threads_clone/utils/helper.dart';

class ProfileController extends GetxController {
  var loading = false.obs;
  Rx<File?> image = Rx<File?>(null);

  //*** Pick image ->
  void pickImage() async {
    File? file = await pickImageFromGallary();
    if (file != null) image.value = file;
  }
}
