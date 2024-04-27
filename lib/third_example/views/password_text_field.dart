import 'package:block_for_managing_state/third_example/strings.dart' show enterYourPasswordHere;
import 'package:flutter/material.dart';
 

class PasswordTextField extends StatelessWidget {
  final TextEditingController passwordController;

  const PasswordTextField({
    Key? key,
    required this.passwordController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: passwordController,
      obscureText: true,
      obscuringCharacter: '◉',
      decoration: const InputDecoration(
        hintText: enterYourPasswordHere,
      ),
    );
  }
}