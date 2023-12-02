import 'package:flutter/material.dart';
import 'package:threads_clone/models/reply_model.dart';
import 'package:threads_clone/utils/helper.dart';

class CommentCardTopBar extends StatelessWidget {
  final ReplyModel reply;

  const CommentCardTopBar({
    super.key,
    required this.reply,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          reply.user!.metadata!.name!,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              formatDateFromNow(
                reply.createdAt!,
              ),
            ),
            const Icon(Icons.more_horiz),
          ],
        ),
      ],
    );
  }
}
