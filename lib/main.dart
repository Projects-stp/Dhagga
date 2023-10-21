import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:threads_clone/routes/routes.dart';
import 'package:threads_clone/routes/routes_name.dart';
import 'package:threads_clone/theme/theme.dart';

void main() {
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
      initialRoute: RouteNames.home,
    );
  }
}
