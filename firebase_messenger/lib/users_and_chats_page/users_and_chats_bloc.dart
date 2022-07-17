import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'users_and_chats_event.dart';
part 'users_and_chats_state.dart';

class UsersAndChatsBloc extends Bloc<UsersAndChatsEvent, UsersAndChatsState> {
  UsersAndChatsBloc() : super(UsersAndChatsState()) {
    on<UsersAndChatsEvent>((event, emit) {

    });
  }
}
