import 'package:firebase_messenger/authorization_page/auth_bloc.dart';
import 'package:firebase_messenger/authorization_page/widgets/auth_text_form_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpWidget extends StatelessWidget {
  final AuthBloc bloc;

  const SignUpWidget({
    Key? key,
    required this.bloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      height: 320,
      child: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            AuthTextFormField(
              inputAction: TextInputAction.next,
              obscureText: false,
              labelText: 'enter your email',
              icon: Icons.alternate_email,
              controller: bloc.emailController,
              errorMessage: bloc.state.emailErrorMessage,
              action: () => bloc.add(EmailSubmitted(isSignUp: true)),
            ),
            AuthTextFormField(
              inputAction: TextInputAction.next,
              obscureText: false,
              labelText: 'create password',
              icon: Icons.lock_outline,
              controller: bloc.passwordController,
              errorMessage: bloc.state.passwordErrorMessage,
              action: () => bloc.add(PasswordSubmitted()),
            ),
            AuthTextFormField(
              inputAction: TextInputAction.done,
              obscureText: false,
              labelText: 'choose your name',
              icon: Icons.person_outline,
              controller: bloc.nameController,
              errorMessage: bloc.state.nameErrorMessage,
              action: () => bloc.add(NameSubmitted()),
            ),
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                return ElevatedButton(
                  onPressed: () => bloc.add(PressedSignUp()),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                  ),
                  child: const SizedBox(
                    width: 140,
                    child: Text(
                      'Sign Up',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                );
              },
            ),
            RichText(
              maxLines: 2,
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: 'Already have an account? ',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => bloc.add(SignInOrSighUpToggle()),
                    text: 'Sign In',
                    style: const TextStyle(
                      color: Colors.deepPurpleAccent,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
