import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:threads_clone/views/home/home_page.dart';
import 'package:threads_clone/views/notification/notifications.dart';
import 'package:threads_clone/views/profile/profile.dart';
import 'package:threads_clone/views/search/search.dart';
import 'package:threads_clone/views/threads/add_threads.dart';

class NavigationService extends GetxService {
  RxInt currentIndex = 0.obs;
  RxInt previousIndex = 0.obs;

  void updateIndex(int index) {
    previousIndex.value = currentIndex.value;
    currentIndex.value = index;
  }

  void backToPrevIndex() {
    currentIndex.value = previousIndex.value;
  }

  List<Widget> pages() {
    return [
      const HomePage(),
      const Search(),
      const AddThreads(),
      const Notifications(),
      const Profile(),
    ];
  }
}
