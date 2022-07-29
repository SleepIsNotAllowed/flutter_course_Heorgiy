part of 'users_and_chats_bloc.dart';

@immutable
abstract class UsersAndChatsEvent {}

class InitializeBloc extends UsersAndChatsEvent {}

class NavigationChanged extends UsersAndChatsEvent {
  final int index;

  NavigationChanged({required this.index});
}

class RefreshUsersList extends UsersAndChatsEvent {
  final List<UserContactInfo> usersList;

  RefreshUsersList({required this.usersList});
}

class RefreshChatsList extends UsersAndChatsEvent {
  final List<ChatInfo> chatsList;

  RefreshChatsList({required this.chatsList});
}

class RefreshUsersPresence extends UsersAndChatsEvent{}

class UserSignOut extends UsersAndChatsEvent {}
