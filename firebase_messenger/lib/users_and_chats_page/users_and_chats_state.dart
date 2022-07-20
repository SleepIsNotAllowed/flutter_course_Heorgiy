part of 'users_and_chats_bloc.dart';

@immutable
class UsersAndChatsState {
  final int? navigationIndex;
  final List<UserContactInfo>? usersData;

  const UsersAndChatsState({
    this.navigationIndex,
    this.usersData,
  });

  UsersAndChatsState copyWith({
    int? navigationIndex,
    List<UserContactInfo>? usersData,
  }) {
    return UsersAndChatsState(
      navigationIndex: navigationIndex ?? this.navigationIndex,
      usersData: usersData ?? this.usersData,
    );
  }
}
