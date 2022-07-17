part of 'users_and_chats_bloc.dart';

@immutable
abstract class UsersAndChatsEvent {}

class NavigationChanged extends UsersAndChatsEvent {
  final int index;

  NavigationChanged({required this.index});
}