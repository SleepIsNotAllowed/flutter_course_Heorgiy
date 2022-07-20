part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class UserSignIn extends AuthEvent {}

class UserSignUp extends AuthEvent {}

class UserSignOut extends AuthEvent {}

class AuthForgotPass extends AuthEvent {}

class SignInOrSighUpToggle extends AuthEvent {}

class AuthExit extends AuthEvent {}
