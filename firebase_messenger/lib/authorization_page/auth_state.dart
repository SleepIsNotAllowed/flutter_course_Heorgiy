part of 'auth_bloc.dart';

@immutable
class AuthState {
  final String? passwordErrorMessage;
  final String? emailErrorMessage;
  final String? nameErrorMessage;
  final AuthStatus authStatus;

  const AuthState({
    this.passwordErrorMessage,
    this.emailErrorMessage,
    this.nameErrorMessage,
    this.authStatus = AuthStatus.signIn,
  });

  AuthState copyWith({
    String? passwordErrorMessage,
    String? emailErrorMessage,
    String? nameErrorMessage,
    AuthStatus? authStatus,
  }) {
    return AuthState(
      passwordErrorMessage: passwordErrorMessage ?? this.passwordErrorMessage,
      emailErrorMessage: emailErrorMessage ?? this.emailErrorMessage,
      nameErrorMessage: nameErrorMessage ?? this.nameErrorMessage,
      authStatus: authStatus ?? this.authStatus,
    );
  }

  AuthState copyWithNull({
    String? passwordErrorMessage,
    String? emailErrorMessage,
    String? nameErrorMessage,
    AuthStatus? authStatus,
  }) {
    return AuthState(
      passwordErrorMessage: passwordErrorMessage,
      emailErrorMessage: emailErrorMessage,
      nameErrorMessage: nameErrorMessage,
      authStatus: authStatus ?? this.authStatus,
    );
  }
}

enum AuthStatus {
  signIn,
  signUp,
  forgotPassword,
  loading,
  inputError,
  unexpectedError,
  authorized,
}
