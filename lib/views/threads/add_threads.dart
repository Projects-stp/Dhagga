import 'package:flutter/material.dart';
import 'package:threads_clone/widgets/add_thread_appbar.dart';

class AddThreads extends StatefulWidget {
  const AddThreads({super.key});

  @override
  State<AddThreads> createState() => _AddThreadsState();
}

class _AddThreadsState extends State<AddThreads> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              AddThreadAppBar(),
            ],
          ),
        ),
      ),
    );
  }
}
