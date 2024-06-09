import 'package:flutter/material.dart';

import 'package:medishield/common/widgets/appbar/appbar.dart';

import 'package:medishield/features/shop/screens/chat/chat_widget.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: TAppBar(
        title: Text('Chat with AI'),
        showBackArrow: true,
      ),
      body: ChatWidget(),
    );
  }
}
