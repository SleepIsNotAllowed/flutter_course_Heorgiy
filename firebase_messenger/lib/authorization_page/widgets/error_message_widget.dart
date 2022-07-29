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
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          border: Border.all(
            color: Colors.red,
            width: 2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Unexpected error occurred, check your internet connection',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.red,
                fontSize: 24,
              ),
            ),
            ElevatedButton(
              onPressed: () => bloc.add(ReturnToSignIn()),
              child: const Text('Return'),
            ),
          ],
        ),
      ),
    );
  }
}
