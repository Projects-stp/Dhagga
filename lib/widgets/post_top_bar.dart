import 'package:flutter/material.dart';
import 'package:threads_clone/models/post_model.dart';
import 'package:threads_clone/utils/helper.dart';

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
        Row(
          children: [
            Text(
              formatDateFromNow(
                post.createdAt!,
              ),
            ),
            const SizedBox(width: 10.0),
            const Icon(Icons.more_horiz),
          ],
        ),
      ],
    );
  }
}
