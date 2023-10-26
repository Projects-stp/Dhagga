import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:threads_clone/routes/routes.dart';
import 'package:threads_clone/routes/routes_name.dart';
import 'package:threads_clone/service/supabase_service.dart';
import 'package:threads_clone/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //*** env load ->
  await dotenv.load(fileName: '.env');
  await GetStorage.init();
  Get.put(SupabaseService());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Threads Clone',
      theme: theme,
      getPages: Routes.pages,
      initialRoute: RouteNames.login,
      defaultTransition: Transition.noTransition,
    );
  }
}
