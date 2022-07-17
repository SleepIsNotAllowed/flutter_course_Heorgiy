import 'package:flutter/material.dart';

class AuthTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputAction inputAction;
  final bool obscureText;
  final String labelText;
  final IconData icon;
  final String? Function(String?) validator;
  final String? errorMessage;

  const AuthTextFormField({
    Key? key,
    this.controller,
    required this.inputAction,
    required this.obscureText,
    required this.labelText,
    required this.icon,
    required this.validator,
    required this.errorMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      textInputAction: inputAction,
      cursorColor: Colors.deepPurpleAccent,
      obscureText: obscureText,
      validator: (input) => validator(input),
      decoration: InputDecoration(
        errorText: errorMessage,
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.deepPurple),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.deepPurple, width: 2),
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.deepPurpleAccent),
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
          ),
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 2),
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        prefixIcon: Icon(
          icon,
          size: 20,
          color: Colors.deepPurpleAccent,
        ),
        prefixIconConstraints: const BoxConstraints(minWidth: 28),
      ),
    );
  }

  String? validateInput(String input) {
    if (labelText == 'email' &&
        !RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
            .hasMatch(input)) {
      return 'Incorrect email';
    } else if (labelText == 'create password' && input.length < 6) {
      return 'Password minimum length - 6 symbols';
    }

    return null;
  }
}
