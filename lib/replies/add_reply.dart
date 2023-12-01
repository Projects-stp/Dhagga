import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:threads_clone/controllers/reply_controller.dart';
import 'package:threads_clone/models/post_model.dart';
import 'package:threads_clone/widgets/image_circle.dart';
import 'package:threads_clone/widgets/post_card_image.dart';

class AddReply extends StatelessWidget {
  AddReply({super.key});

  final PostModel post = Get.arguments;
  final ReplyController controller = Get.put(ReplyController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.close),
        ),
        title: const Text(
          "Reply",
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text('Comment'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: context.width * 0.12,
              child: CircleImage(url: post.user?.metadata?.image),
            ),
            const SizedBox(width: 10),
            SizedBox(
              width: context.width * 0.80,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post.user!.metadata!.name!,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(post.content!),
                  const SizedBox(height: 14.0),
                  if (post.image != null) PostCardImage(url: post.image!),
                  const SizedBox(height: 20.0),
                  TextField(
                    autofocus: true,
                    controller: controller.replyController,
                    onChanged: (value) => controller.reply.value = value,
                    style: const TextStyle(fontSize: 14),
                    maxLines: 10,
                    minLines: 1,
                    maxLength: 1000,
                    decoration: InputDecoration(
                      hintText: "Reply to ${post.user!.metadata!.name!}",
                      border: InputBorder.none, // Remove border
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
