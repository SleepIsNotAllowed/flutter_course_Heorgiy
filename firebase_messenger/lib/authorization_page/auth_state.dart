part of 'auth_bloc.dart';

@immutable
class AuthState {
  final String? passwordErrorMessage;
  final String? emailErrorMessage;
  final AuthStatus authStatus;

  const AuthState({
    this.passwordErrorMessage,
    this.emailErrorMessage,
    this.authStatus = AuthStatus.signIn,
  });

  AuthState copyWith({
    String? passwordErrorMessage,
    String? emailErrorMessage,
    AuthStatus? authStatus,
  }) {
    return AuthState(
      passwordErrorMessage: passwordErrorMessage,
      emailErrorMessage: emailErrorMessage,
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
