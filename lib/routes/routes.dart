import 'package:get/route_manager.dart';
import 'package:threads_clone/routes/routes_name.dart';
import 'package:threads_clone/views/home_screen.dart';

class Routes {
  static final pages = [
    GetPage(
      name: RouteNames.home,
      page: () => const HomeScreen(),
    ),
  ];
}
