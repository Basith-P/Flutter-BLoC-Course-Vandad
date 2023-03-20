import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'email_field.dart';
import 'login_button.dart';
import 'passwd_field.dart';

class LoginView extends HookWidget {
  final OnLoginTapped onLoginTapped;

  const LoginView({required this.onLoginTapped, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          EmailTextField(emailController: emailController),
          const SizedBox(height: 20),
          PasswordTextField(passwordController: passwordController),
          const SizedBox(height: 20),
          LoginButton(
            emailController: emailController,
            passwordController: passwordController,
            onLoginTapped: onLoginTapped,
          ),
        ],
      ),
    );
  }
}
