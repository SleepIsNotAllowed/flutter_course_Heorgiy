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

  AuthBloc() : super(const AuthState()) {
    on<EmailSubmitted>((event, emit) async {
      String email = emailController.text.trim();
      String? errorMessage = validateEmail(email);
      errorMessage ??= await authClient.validateEmail(email, event.isSignUp);
      emit(state.copyWithNull(
        emailErrorMessage: errorMessage,
        passwordErrorMessage: state.passwordErrorMessage,
        nameErrorMessage: state.nameErrorMessage,
      ));
    });

    on<PasswordSubmitted>((event, emit) async {
      String password = passwordController.text;
      String? errorMessage = validatePassword(password);
      emit(state.copyWithNull(
        emailErrorMessage: state.emailErrorMessage,
        passwordErrorMessage: errorMessage,
        nameErrorMessage: state.nameErrorMessage,
      ));
    });

    on<NameSubmitted>((event, emit) async {
      String name = nameController.text.trim();
      String? errorMessage = validateName(name);
      emit(state.copyWithNull(
        emailErrorMessage: state.emailErrorMessage,
        passwordErrorMessage: state.passwordErrorMessage,
        nameErrorMessage: errorMessage,
      ));
    });

    on<PressedSignIn>((event, emit) async {
      String? emailError = validateEmail(emailController.text.trim());
      String? passwordError = validatePassword(passwordController.text);
      if (emailError == null || passwordError == null) {
        emit(state.copyWith(
          emailErrorMessage: null,
          passwordErrorMessage: null,
          authStatus: AuthStatus.loading,
        ));
        add(UserSignIn());
      } else {
        emit(state.copyWith(
          emailErrorMessage: emailError,
          passwordErrorMessage: passwordError,
        ));
      }
    });

    on<UserSignIn>((event, emit) async {
      String? result = await authClient.signInWithEmailAndPassword(
        emailController.text.trim(),
        passwordController.text,
      );

      if (result == null) {
        _clearTextFields();
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

    on<PressedSignUp>((event, emit) async {
      String? emailError = validateEmail(emailController.text.trim());
      String? passwordError = validatePassword(passwordController.text);
      String? nameError = validateName(nameController.text.trim());
      if (emailError == null && passwordError == null && nameError == null) {
        emit(state.copyWith(
          emailErrorMessage: null,
          passwordErrorMessage: null,
          nameErrorMessage: null,
          authStatus: AuthStatus.loading,
        ));
        add(UserSignUp());
      } else {
        emit(state.copyWith(
          emailErrorMessage: emailError,
          passwordErrorMessage: passwordError,
          nameErrorMessage: nameError,
        ));
      }
    });

    on<UserSignUp>((event, emit) async {
      String? result = await authClient.signUpWithEmailAndPassword(
        emailController.text.trim(),
        passwordController.text,
        nameController.text.trim(),
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

    on<SignInOrSighUpToggle>((event, emit) {
      _clearTextFields();
      if (state.authStatus != AuthStatus.signUp) {
        emit(state.copyWithNull(
          authStatus: AuthStatus.signUp,
        ));
      } else {
        emit(state.copyWithNull(
          authStatus: AuthStatus.signIn,
        ));
      }
    });

    on<ReturnToSignIn>((event, emit) {
      emit(state.copyWith(authStatus: AuthStatus.signIn));
    });
  }

  String? validateEmail(String? input) {
    String? result;

    if (input == null || input.isEmpty) {
      result = 'Empty email field';
    } else if (!RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(input)) {
      result = 'Incorrect email';
    }
    return result;
  }

  String? validatePassword(String? input) {
    String? result;

    if (input == null || input.isEmpty) {
      result = 'Empty password field';
    } else if (input.length < 6) {
      result = 'Password must contain at least 6 symbols';
    }
    return result;
  }

  String? validateName(String? input) {
    String? result;

    if (input == null || input.isEmpty) {
      result = 'Empty name field';
    } else if (input.toLowerCase().replaceAll(' ', '') == 'yourdad') {
      result = 'Nope, you are not';
    }
    return result;
  }

  void _clearTextFields() {
    emailController.clear();
    passwordController.clear();
    nameController.clear();
  }
}
