import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:threads_clone/controllers/profile_controller.dart';
import 'package:threads_clone/service/supabase_service.dart';
import 'package:threads_clone/utils/sliver_appbar_delegate.dart';
import 'package:threads_clone/utils/styles/button_styles.dart';
import 'package:threads_clone/widgets/image_circle.dart';

import '../../routes/routes_name.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  //??
  final ProfileController controller = Get.put(ProfileController());
  final SupabaseService supabaseService = Get.find<SupabaseService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Icon(Icons.language),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () => Get.toNamed(RouteNames.setting),
            icon: const Icon(Icons.sort),
          ),
        ],
      ),
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 160.0,
                collapsedHeight: 160.0,
                automaticallyImplyLeading: false,
                flexibleSpace: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Obx(
                            () => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  supabaseService
                                      .currentUser.value?.userMetadata?["name"],
                                  style: const TextStyle(
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.8,
                                  ),
                                ),
                                SizedBox(
                                  width: context.width * 0.60,
                                  child: Text(
                                    supabaseService.currentUser.value
                                            ?.userMetadata?["description"] ??
                                        'I am batman',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Obx(
                            () => CircleImage(
                              url: supabaseService
                                  .currentUser.value?.userMetadata?["image"],
                              radius: 40,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {
                                Get.toNamed(RouteNames.editProfile);
                              },
                              style: customOutlineStyle(),
                              child: const Text("Edit profile"),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {},
                              style: customOutlineStyle(),
                              child: const Text("Share profile"),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
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
          body: const TabBarView(
            children: [
              Text('I am threads'),
              Text('I am replies'),
            ],
          ),
        ),
      ),
    );
  }
}
