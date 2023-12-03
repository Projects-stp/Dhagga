import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:threads_clone/models/post_model.dart';
import 'package:threads_clone/service/supabase_service.dart';

import '../models/user_model.dart';

class HomeController extends GetxController {
  RxList<PostModel> posts = RxList<PostModel>();
  var loading = false.obs;

  @override
  void onInit() async {
    await fetchThreads();
    listenChange();
    super.onInit();
  }

  //??
  Future<void> fetchThreads() async {
    loading.value = true;
    final List<dynamic> response =
        await SupabaseService.client.from("posts").select('''
    id,content,image,created_at,comment_count,like_count,user_id,
    user:user_id (email , metadata), likes:likes (user_id ,post_id)
''').order("id", ascending: false);
    loading.value = false;
    if (response.isNotEmpty) {
      posts.value = [for (var item in response) PostModel.fromJson(item)];
    }
  }

  //??
  void listenChange() {
    SupabaseService.client.channel('public:posts').on(
      RealtimeListenTypes.postgresChanges,
      ChannelFilter(event: 'INSERT', schema: 'public', table: 'posts'),
      (payload, [ref]) {
        final PostModel post = PostModel.fromJson(payload["new"]);
        updateFeed(post);
      },
    ).on(
      RealtimeListenTypes.postgresChanges,
      ChannelFilter(event: 'DELETE', schema: 'public', table: 'posts'),
      (payload, [ref]) {
        posts.removeWhere((element) => element.id == payload["old"]["id"]);
      },
    ).subscribe();
  }

  //??
  void updateFeed(PostModel post) async {
    var user = await SupabaseService.client
        .from("users")
        .select("*")
        .eq("id", post.userId)
        .single();

    //!! Fetch likes
    post.likes = [];
    post.user = UserModel.fromJson(user);
    posts.insert(0, post);
  }
}
