import 'dart:math';

import 'package:firebase_messenger/networking/firebase_auth_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuthClient authClient = FirebaseAuthClient();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  AuthBloc() : super(const AuthState()) {
    on<UserSignIn>((event, emit) async {
      if (!formKey.currentState!.validate()) return;
      emit(state.copyWith(
        emailErrorMessage: null,
        passwordErrorMessage: null,
        authStatus: AuthStatus.loading,
      ));
      String? result = await authClient.signInWithEmailAndPassword(
        emailController.text,
        passwordController.text,
      );
      if (result == null) {
        emit(state.copyWith(authStatus: AuthStatus.authorized));
      } else if (result == 'Wrong password') {
        emit(state.copyWith(
          passwordErrorMessage: result,
          authStatus: AuthStatus.signIn,
        ));
      } else if (result == 'No users with this email') {
        emit(state.copyWith(
          emailErrorMessage: result,
          authStatus: AuthStatus.signIn,
        ));
      } else if (result == 'Error') {
        emit(state.copyWith(authStatus: AuthStatus.unexpectedError));
      }
    });

    on<UserSignUp>((event, emit) async {
      if (!formKey.currentState!.validate()) return;
      emit(state.copyWith(
        emailErrorMessage: null,
        passwordErrorMessage: null,
        authStatus: AuthStatus.loading,
      ));
      String? result = await authClient.signUpWithEmailAndPassword(
        emailController.text,
        passwordController.text,
        nameController.text,
        Random().nextInt(Colors.primaries.length),
      );
      if (result == null) {
        emit(state.copyWith(authStatus: AuthStatus.signIn));
      } else if (result == 'Email already registered') {
        emit(state.copyWith(
          emailErrorMessage: result,
          authStatus: AuthStatus.signUp,
        ));
      } else if (result == 'Error') {
        emit(state.copyWith(authStatus: AuthStatus.unexpectedError));
      }
    });

    on<UserSignOut>((event, emit) async {
      emit(state.copyWith(authStatus: AuthStatus.loading));
      await authClient.signOut();
      emit(state.copyWith(authStatus: AuthStatus.signIn));
    });

    on<SignInOrSighUpToggle>((event, emit) {
      emailController.clear();
      passwordController.clear();
      nameController.clear();
      if (state.authStatus != AuthStatus.signUp) {
        emit(state.copyWith(
          emailErrorMessage: null,
          passwordErrorMessage: null,
          authStatus: AuthStatus.signUp,
        ));
      } else {
        emit(state.copyWith(
          emailErrorMessage: null,
          passwordErrorMessage: null,
          authStatus: AuthStatus.signIn,
        ));
      }
    });
  }
}
