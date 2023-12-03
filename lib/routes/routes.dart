import 'package:get/route_manager.dart';
import 'package:threads_clone/replies/add_reply.dart';
import 'package:threads_clone/routes/routes_name.dart';
import 'package:threads_clone/views/auth/login_screen.dart';
import 'package:threads_clone/views/auth/register.dart';
import 'package:threads_clone/views/home_screen.dart';
import 'package:threads_clone/views/profile/edit_profile.dart';
import 'package:threads_clone/views/profile/show_user.dart';
import 'package:threads_clone/views/settings/settings.dart';
import 'package:threads_clone/views/threads/show_image.dart';
import 'package:threads_clone/views/threads/show_threads.dart';

class Routes {
  static final pages = [
    GetPage(
      name: RouteNames.home,
      page: () => HomeScreen(),
    ),
    GetPage(
      name: RouteNames.login,
      page: () => const LoginScreen(),
      transition: Transition.fade,
    ),
    GetPage(
      name: RouteNames.register,
      page: () => const RegisterScreen(),
      transition: Transition.fade,
    ),
    GetPage(
      name: RouteNames.editProfile,
      page: () => const EditProfile(),
      transition: Transition.leftToRight,
    ),
    GetPage(
      name: RouteNames.setting,
      page: () => Setting(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: RouteNames.addComment,
      page: () => AddReply(),
      transition: Transition.downToUp,
    ),
    GetPage(
      name: RouteNames.showThread,
      page: () => const ShowThread(),
      transition: Transition.leftToRight,
    ),
    GetPage(
      name: RouteNames.showImage,
      page: () => ShowImage(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: RouteNames.showUser,
      page: () => const ShowUser(),
      transition: Transition.fadeIn,
    ),
  ];
}
