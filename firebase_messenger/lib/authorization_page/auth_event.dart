part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class EmailSubmitted extends AuthEvent {
  final bool isSignUp;

  EmailSubmitted({required this.isSignUp});
}

class PasswordSubmitted extends AuthEvent {}

class NameSubmitted extends AuthEvent {}

class PressedSignIn extends AuthEvent {}

class UserSignIn extends AuthEvent {}

class PressedSignUp extends AuthEvent {}

class UserSignUp extends AuthEvent {}

class SignInOrSighUpToggle extends AuthEvent {}

class ReturnToSignIn extends AuthEvent {}
