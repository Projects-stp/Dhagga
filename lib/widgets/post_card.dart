import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:threads_clone/models/post_model.dart';
import 'package:threads_clone/widgets/post_card_bottom_bar.dart';
import 'package:threads_clone/widgets/post_card_image.dart';
import 'package:threads_clone/widgets/post_top_bar.dart';

import 'image_circle.dart';

class PostCard extends StatelessWidget {
  final PostModel post;

  const PostCard({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: context.width * 0.12,
                child: Column(
                  children: [
                    CircleImage(url: post.user?.metadata?.image),
                  ],
                ),
              ),
              const SizedBox(width: 10.0),
              SizedBox(
                width: context.width * 0.80,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PostTopBar(post: post),
                    Text(post.content!),
                    const SizedBox(height: 10.0),
                    if (post.image != null) PostCardImage(url: post.image!),
                    PostCardBottomBar(post: post),
                  ],
                ),
              ),
            ],
          ),
          const Divider(
            color: Color(0xff242424),
          ),
        ],
      ),
    );
  }
}
