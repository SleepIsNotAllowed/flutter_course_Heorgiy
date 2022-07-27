import 'package:firebase_messenger/chat_page/chat_bloc.dart';
import 'package:firebase_messenger/chat_page/widgets/chat_bottom_bar.dart';
import 'package:firebase_messenger/chat_page/widgets/messages_view.dart';
import 'package:firebase_messenger/chat_page/widgets/top_bar.dart';
import 'package:firebase_messenger/data_models/user_contact_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScaffold extends StatefulWidget {
  final UserContactInfo partakerInfo;

  const ChatScaffold({Key? key, required this.partakerInfo}) : super(key: key);

  @override
  State<ChatScaffold> createState() => _ChatScaffoldState();
}

class _ChatScaffoldState extends State<ChatScaffold> {

  /*
  Using Future.microtask() to add event to bloc that will trigger
  loading of initial batch of read messages, if any exist.
   */
  @override
  void initState() {
    Future.microtask(() => context.read<ChatBloc>().add(InitialLoad()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: TopBar(userInfo: widget.partakerInfo),
      body: Column(
        children: [
          Expanded(
            child: MessagesView(partakerName: widget.partakerInfo.name),
          ),
          const ChatBottomBar(),
        ],
      ),
    );
  }
}
