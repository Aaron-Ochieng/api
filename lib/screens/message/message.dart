import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessageView extends GetView {
  const MessageView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Messages'),
      ),
    );
  }
}
