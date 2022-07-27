import 'package:firebase_messenger/chat_page/chat_bloc.dart';
import 'package:firebase_messenger/data_models/user_contact_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  final UserContactInfo userInfo;

  const TopBar({Key? key, required this.userInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leadingWidth: 100,
      leading: GestureDetector(
        onTap: () {
          context.read<ChatBloc>().add(LeaveChat());
          Navigator.pop(context);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: const [
              Icon(
                Icons.arrow_back_ios_rounded,
                color: Colors.deepPurpleAccent,
              ),
              Text(
                'Back',
                style: TextStyle(
                  color: Colors.deepPurpleAccent,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),
      toolbarHeight: 50,
      backgroundColor: Colors.grey.shade200,
      actions: [
        _buildParticipantIcon(userInfo),
      ],
      centerTitle: true,
      title: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          return Column(
            children: [
              Text(
                userInfo.name,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.black),
              ),
              Text(
                _choosePartakerStatus(state),
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildParticipantIcon(UserContactInfo userInfo) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: CircleAvatar(
        backgroundColor: userInfo.thumbnailColor,
        child: Text(
          userInfo.name[0].toUpperCase(),
          style: const TextStyle(color: Colors.white, fontSize: 19),
        ),
      ),
    );
  }

  String _choosePartakerStatus(ChatState state) {
    if (state.partakerLastSeen == null) {
      return 'connecting...';
    } else {
      bool isOffline = DateTime.now()
              .difference(
                  DateTime.fromMillisecondsSinceEpoch(state.partakerLastSeen!))
              .inMinutes >
          3;
      return isOffline ? 'offline' : 'online';
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
