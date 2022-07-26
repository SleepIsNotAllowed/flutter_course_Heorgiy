import 'package:firebase_messenger/chat_page/chat_bloc.dart';
import 'package:firebase_messenger/chat_page/widgets/chat_scaffold.dart';
import 'package:firebase_messenger/data_models/user_contact_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    UserContactInfo partakerInfo = arguments['partakerInfo'];

    return BlocProvider<ChatBloc>(
      create: (context) => ChatBloc(
        chatName: arguments['chatName'],
        partakerId: partakerInfo.userId,
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.purple.shade800,
              Colors.deepPurple,
              Colors.blue.shade800,
            ],
          ),
        ),
        child: ChatScaffold(partakerInfo: partakerInfo),
      ),
    );
  }
}
