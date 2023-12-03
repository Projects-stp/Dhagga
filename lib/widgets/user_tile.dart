import 'package:flutter/material.dart';
import 'package:threads_clone/models/user_model.dart';
import 'package:threads_clone/utils/styles/button_styles.dart';

import '../utils/helper.dart';
import 'image_circle.dart';

class UserTile extends StatelessWidget {
  final UserModel user;

  const UserTile({
    required this.user,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Padding(
        padding: const EdgeInsets.only(top: 5),
        child: CircleImage(url: user.metadata?.image),
      ),
      title: Text(user.metadata!.name!),
      titleAlignment: ListTileTitleAlignment.top,
      trailing: OutlinedButton(
        onPressed: () {},
        style: customOutlineStyle(),
        child: const Text("View profile"),
      ),
      subtitle: Text(
        formatDateFromNow(user.createdAt!),
      ),
    );
  }
}
