part of 'users_and_chats_bloc.dart';

@immutable
class UsersAndChatsState {
  final String? currentUserId;
  final int? navigationIndex;
  final List<UserContactInfo>? usersList;
  final List<ChatInfo>? chatsList;

  const UsersAndChatsState({
    this.currentUserId,
    this.navigationIndex,
    this.usersList,
    this.chatsList,
  });

  UsersAndChatsState copyWith({
    String? currentUserId,
    int? navigationIndex,
    List<UserContactInfo>? usersList,
    List<ChatInfo>? chatsList,
  }) {
    return UsersAndChatsState(
      currentUserId: currentUserId ?? this.currentUserId,
      navigationIndex: navigationIndex ?? this.navigationIndex,
      usersList: usersList ?? this.usersList,
      chatsList: chatsList ?? this.chatsList,
    );
  }
}
