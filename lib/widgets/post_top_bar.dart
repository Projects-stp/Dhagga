import 'package:flutter/material.dart';
import 'package:threads_clone/models/post_model.dart';

class PostTopBar extends StatelessWidget {
  final PostModel post;

  const PostTopBar({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}
