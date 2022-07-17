import 'package:firebase_messenger/authorization_page/auth_bloc.dart';
import 'package:firebase_messenger/authorization_page/widgets/auth_text_form_field.dart';
import 'package:flutter/material.dart';

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
        key: bloc.formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            AuthTextFormField(
              key: UniqueKey(),
              inputAction: TextInputAction.next,
              obscureText: false,
              labelText: 'enter your email',
              icon: Icons.alternate_email,
              controller: bloc.emailController,
              errorMessage: bloc.state.emailErrorMessage,
              validator: emailValidation,
            ),
            AuthTextFormField(
              key: UniqueKey(),
              inputAction: TextInputAction.next,
              obscureText: false,
              labelText: 'create password',
              icon: Icons.lock_outline,
              controller: bloc.passwordController,
              errorMessage: bloc.state.passwordErrorMessage,
              validator: passwordValidation,
            ),
            AuthTextFormField(
              key: UniqueKey(),
              inputAction: TextInputAction.done,
              obscureText: false,
              labelText: 'choose your name',
              icon: Icons.person_outline,
              controller: bloc.nameController,
              errorMessage: null,
              validator: namedValidation,
            ),
            ElevatedButton(
              onPressed: () => bloc.add(AuthSignUp()),
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
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Already have an account? ',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                GestureDetector(
                  onTap: () => bloc.add(AuthCreateAccount()),
                  child: const Text(
                    'Log In',
                    style: TextStyle(
                      color: Colors.deepPurpleAccent,
                    ),
                  ),
                )
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
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(input)) {
      result = 'Incorrect email';
    }
    return result;
  }

  String? passwordValidation(String? input) {
    String? result;

    if (input == null || input.isEmpty) {
      result = 'Empty password field';
    } else if (input.length < 6) {
      result = 'Password must contain 6 symbols minimum';
    }
    return result;
  }

  String? namedValidation(String? input) {
    String? result;

    if (input == null || input.isEmpty) {
      result = 'Empty name field';
    } else if (input.toLowerCase().replaceAll(' ', '') == 'yourdad') {
      result = 'Nope, you are not';
    }
    return result;
  }
}
