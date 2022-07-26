import 'package:firebase_messenger/authorization_page/auth_bloc.dart';
import 'package:firebase_messenger/authorization_page/widgets/error_message_widget.dart';
import 'package:firebase_messenger/authorization_page/widgets/log_in_widget.dart';
import 'package:firebase_messenger/authorization_page/widgets/sign_up_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthWindow extends StatelessWidget {
  const AuthWindow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 360,
      width: 310,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: const BorderRadius.all(Radius.circular(36)),
      ),
      child: Center(
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            AuthBloc bloc = context.read<AuthBloc>();
            AuthStatus authStatus = state.authStatus;
            if (authStatus == AuthStatus.signIn ||
                authStatus == AuthStatus.authorized) {
              return SignInWidget(bloc: bloc);
            } else if (authStatus == AuthStatus.signUp) {
              return SignUpWidget(bloc: bloc);
            } else if (authStatus == AuthStatus.loading) {
              return _buildProgressIndicator();
            } else if (authStatus == AuthStatus.unexpectedError) {
              return ErrorMessageWidget(bloc: bloc, state: state);
            }
            return const Text('Error');
          },
        ),
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return const CircularProgressIndicator(
      color: Colors.deepPurple,
      strokeWidth: 8,
    );
  }
}
