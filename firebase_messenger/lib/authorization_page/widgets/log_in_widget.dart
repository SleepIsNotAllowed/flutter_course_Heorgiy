import 'package:firebase_messenger/authorization_page/auth_bloc.dart';
import 'package:firebase_messenger/authorization_page/widgets/auth_text_form_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInWidget extends StatelessWidget {
  final AuthBloc bloc;

  const SignInWidget({
    Key? key,
    required this.bloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      height: 270,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          AuthTextFormField(
            inputAction: TextInputAction.next,
            obscureText: false,
            labelText: 'email',
            icon: Icons.alternate_email,
            controller: bloc.emailController,
            errorMessage: bloc.state.emailErrorMessage,
            action: () => bloc.add(EmailSubmitted(isSignUp: false)),
          ),
          AuthTextFormField(
            inputAction: TextInputAction.done,
            obscureText: true,
            labelText: 'password',
            icon: Icons.lock_open,
            controller: bloc.passwordController,
            errorMessage: bloc.state.passwordErrorMessage,
            action: () => bloc.add(PasswordSubmitted()),
          ),
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return ElevatedButton(
                onPressed: () => bloc.add(PressedSignIn()),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                ),
                child: const SizedBox(
                  width: 140,
                  child: Text(
                    'Log In',
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
                  text: 'Don`t have an account? ',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                TextSpan(
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => bloc.add(SignInOrSighUpToggle()),
                  text: 'Sign Up',
                  style: const TextStyle(
                    color: Colors.deepPurpleAccent,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
