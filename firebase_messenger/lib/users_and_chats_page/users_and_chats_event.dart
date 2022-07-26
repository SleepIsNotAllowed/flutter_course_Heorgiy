part of 'users_and_chats_bloc.dart';

@immutable
abstract class UsersAndChatsEvent {}

class NavigationChanged extends UsersAndChatsEvent {
  final int index;

  NavigationChanged({required this.index});
}

class UserSignOut extends UsersAndChatsEvent {}

class RefreshUsersList extends UsersAndChatsEvent {
  final List<UserContactInfo> usersList;

  RefreshUsersList({required this.usersList});
}

class RefreshChatsList extends UsersAndChatsEvent {
  final List<ChatInfo> chatsList;

  RefreshChatsList({required this.chatsList});
}
