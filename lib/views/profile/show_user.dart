import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:threads_clone/controllers/profile_controller.dart';

import '../../routes/routes_name.dart';
import '../../utils/sliver_appbar_delegate.dart';
import '../../widgets/comment_card.dart';
import '../../widgets/image_circle.dart';
import '../../widgets/loading.dart';
import '../../widgets/post_card.dart';

class ShowUser extends StatefulWidget {
  const ShowUser({super.key});

  @override
  State<ShowUser> createState() => _ShowUserState();
}

class _ShowUserState extends State<ShowUser> {
  final String userId = Get.arguments;
  final ProfileController controller = Get.put(ProfileController());

  @override
  void initState() {
    controller.fetchUser(userId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => Get.toNamed(RouteNames.setting),
            icon: const Icon(Icons.sort),
          )
        ],
      ),
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 100,
                collapsedHeight: 100,
                automaticallyImplyLeading: false,
                flexibleSpace: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Obx(
                                () => controller.userLoading.value
                                    ? const Loading()
                                    : Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            controller
                                                .user.value.metadata!.name!,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25,
                                            ),
                                          ),
                                          SizedBox(
                                            width: context.width * 0.60,
                                            child: Text(
                                              controller.user.value.metadata!
                                                  .description!,
                                            ),
                                          ),
                                        ],
                                      ),
                              ),
                              Obx(
                                () => CircleImage(
                                  url: controller.user.value.metadata?.image,
                                  radius: 40,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SliverPersistentHeader(
                floating: true,
                pinned: true,
                delegate: SliverAppBarDelegate(
                  const TabBar(
                    indicatorSize: TabBarIndicatorSize.tab,
                    tabs: [
                      Tab(text: 'Threads'),
                      Tab(text: 'Replies'),
                    ],
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            children: [
              Obx(
                () => SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      if (controller.postLoading.value)
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: CircularProgressIndicator(),
                          ),
                        )
                      else if (controller.posts.isNotEmpty)
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemCount: controller.posts.length,
                          itemBuilder: (context, index) => PostCard(
                            post: controller.posts[index],
                          ),
                        )
                      else
                        const Center(
                          child: Text("No Post found"),
                        ),
                    ],
                  ),
                ),
              ),
              SingleChildScrollView(
                padding: const EdgeInsets.all(8),
                child: Obx(
                  () => controller.replyLoading.value
                      ? const Loading()
                      : Column(
                          children: [
                            const SizedBox(height: 10),
                            if (controller.replies.isNotEmpty)
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                itemCount: controller.replies.length,
                                itemBuilder: (context, index) => CommentCard(
                                  reply: controller.replies[index],
                                ),
                              )
                            else
                              const Center(
                                child: Text("No reply found"),
                              ),
                          ],
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
