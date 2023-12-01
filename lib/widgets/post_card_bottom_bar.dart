import 'package:flutter/material.dart';

import '../models/post_model.dart';

class PostCardBottomBar extends StatelessWidget {
  final PostModel post;

  const PostCardBottomBar({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
            const SizedBox(width: 12.0),
            Text("${post.likeCount} likes"),
          ],
        )
      ],
    );
  }
}
