import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:threads_clone/routes/routes_name.dart';

import '../controllers/thread_controller.dart';
import '../models/post_model.dart';
import '../service/supabase_service.dart';

class PostCardBottomBar extends StatefulWidget {
  final PostModel post;

  const PostCardBottomBar({
    super.key,
    required this.post,
  });

  @override
  State<PostCardBottomBar> createState() => _PostCardBottomBarState();
}

class _PostCardBottomBarState extends State<PostCardBottomBar> {
  final ThreadController controller = Get.find<ThreadController>();
  final SupabaseService supabaseService = Get.find<SupabaseService>();

  String likeStatus = "";

  void likeDislike(String status) async {
    setState(() {
      likeStatus = status;
    });
    if (likeStatus == "0") {
      widget.post.likes = [];
    }
    await controller.likeDislike(
      status,
      widget.post.id!,
      widget.post.userId!,
      supabaseService.currentUser.value!.id,
    );
  }

  //??
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            likeStatus == "1" || widget.post.likes!.isNotEmpty
                ? IconButton(
                    onPressed: () {
                      likeDislike("0");
                    },
                    icon: Icon(
                      Icons.favorite,
                      color: Colors.red[700]!,
                    ),
                  )
                : IconButton(
                    onPressed: () {
                      likeDislike("1");
                    },
                    icon: const Icon(Icons.favorite_outline),
                  ),
            IconButton(
              onPressed: () {
                Get.toNamed(RouteNames.addComment, arguments: widget.post);
              },
              icon: const Icon(Icons.chat_bubble_outline),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.send_outlined),
            ),
          ],
        ),
        Row(
          children: [
            Text("${widget.post.commentCount} replies"),
            const SizedBox(width: 12.0),
            Text("${widget.post.likeCount} likes"),
          ],
        ),
      ],
    );
  }
}
