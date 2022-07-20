import 'package:firebase_messenger/authorization_page/auth_bloc.dart';
import 'package:firebase_messenger/authorization_page/widgets/auth_text_form_field.dart';
import 'package:flutter/material.dart';

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
      child: Form(
        key: bloc.formKey,
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
              validator: emailValidation,
            ),
            AuthTextFormField(
              inputAction: TextInputAction.done,
              obscureText: true,
              labelText: 'password',
              icon: Icons.lock_open,
              controller: bloc.passwordController,
              errorMessage: bloc.state.passwordErrorMessage,
              validator: passwordValidation,
            ),
            ElevatedButton(
              onPressed: () => bloc.add(UserSignIn()),
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
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Don`t have an account? ',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                GestureDetector(
                  onTap: () => bloc.add(SignInOrSighUpToggle()),
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(
                      color: Colors.deepPurpleAccent,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String? emailValidation(String? input) {
    String? result;

    if (input == null || input.isEmpty) {
      result = 'Empty email field';
    } else if (!RegExp(
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
    ).hasMatch(input)) {
      result = 'Incorrect email';
    }
    return result;
  }

  String? passwordValidation(String? input) {
    String? result;

    if (input == null || input.isEmpty) {
      result = 'Empty password field';
    } else if (input.length < 6) {
      result = 'Minimum password length is 6 symbols';
    }
    return result;
  }
}
