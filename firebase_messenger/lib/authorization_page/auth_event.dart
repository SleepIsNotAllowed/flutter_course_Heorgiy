part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class AuthSignIn extends AuthEvent {}

class AuthSignUp extends AuthEvent {}

class AuthSignOut extends AuthEvent {}

class AuthForgotPass extends AuthEvent {}

class AuthCreateAccount extends AuthEvent {}

class AuthExit extends AuthEvent {}
