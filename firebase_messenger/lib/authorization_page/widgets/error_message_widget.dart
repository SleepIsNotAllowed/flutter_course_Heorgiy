import 'package:firebase_messenger/authorization_page/auth_bloc.dart';
import 'package:flutter/material.dart';

class ErrorMessageWidget extends StatelessWidget {
  final AuthBloc bloc;
  final AuthState state;

  const ErrorMessageWidget({
    Key? key,
    required this.bloc,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Unexpected error occurred',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.red,
              fontSize: 32,
            ),
          ),
          ElevatedButton(
            onPressed: () => bloc.add(AuthExit()),
            child: const Text('Return'),
          ),
        ],
      ),
    );
  }
}
