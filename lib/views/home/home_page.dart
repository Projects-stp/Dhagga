import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:threads_clone/controllers/home_controller.dart';
import 'package:threads_clone/widgets/loading.dart';
import 'package:threads_clone/widgets/post_card.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Image.asset(
                  "assets/logo.png",
                  width: 40.0,
                  height: 40.0,
                  fit: BoxFit.contain,
                ),
              ),
              centerTitle: true,
            ),
            SliverToBoxAdapter(
              child: Obx(
                () => controller.loading.value
                    ? const Loading()
                    : ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: const BouncingScrollPhysics(),
                        itemCount: controller.posts.length,
                        itemBuilder: (context, index) => PostCard(
                          post: controller.posts[index],
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
