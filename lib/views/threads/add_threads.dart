import 'package:flutter/material.dart';

class AddThreads extends StatefulWidget {
  const AddThreads({super.key});

  @override
  State<AddThreads> createState() => _AddThreadsState();
}

class _AddThreadsState extends State<AddThreads> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Threads'),
      ),
    );
  }
}
