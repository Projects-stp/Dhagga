import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:threads_clone/models/reply_model.dart';

import 'comment_card_top_bar.dart';
import 'image_circle.dart';

class CommentCard extends StatelessWidget {
  final ReplyModel reply;

  const CommentCard({
    super.key,
    required this.reply,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: context.width * 0.12,
              child: CircleImage(
                url: reply.user!.metadata?.image,
              ),
            ),
            const SizedBox(width: 10),
            SizedBox(
              width: context.width * 0.80,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommentCardTopBar(
                    reply: reply,
                  ),
                  Text(reply.reply!),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
        const Divider(
          color: Color(0xff242424),
        ),
      ],
    );
  }
}
