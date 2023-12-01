import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:threads_clone/models/post_model.dart';
import 'package:threads_clone/utils/helper.dart';

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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          post.user!.metadata!.name!,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const Row(
                          children: [
                            Text('Hi hello'),
                            SizedBox(width: 10.0),
                            Icon(Icons.more_horiz),
                          ],
                        ),
                      ],
                    ),
                    Text(post.content!),
                    const SizedBox(height: 10.0),
                    if (post.image != null)
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          maxHeight: context.height * 0.60,
                          maxWidth: context.width * 0.80,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Image.network(
                            getS3Url(post.image!),
                            fit: BoxFit.cover,
                            alignment: Alignment.topCenter,
                          ),
                        ),
                      ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.favorite_outline),
                        ),
                        IconButton(
                          onPressed: () {},
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
                        Text("${post.commentCount} replies"),
                        const SizedBox(width: 10.0),
                        Text("${post.likeCount} likes"),
                      ],
                    ),
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
