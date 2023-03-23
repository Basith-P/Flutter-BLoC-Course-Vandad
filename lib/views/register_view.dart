import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../bloc/app_bloc.dart';
import '../utils/if_debugging.dart';
import '../utils/vars/input_decorations.dart';

class RegisterView extends HookWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final emailController =
        useTextEditingController(text: 'abc@xyz.com'.ifDebugging);
    final passwordController =
        useTextEditingController(text: 'foobar'.ifDebugging);

    final appBloc = context.watch<AppBloc>();

    return Scaffold(
        body: Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Register',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 32.0),
            TextField(
              controller: emailController,
              decoration: kInputDecoration.copyWith(hintText: 'Email'),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16.0),
            TextField(
              controller: passwordController,
              decoration: kInputDecoration.copyWith(hintText: 'Password'),
              obscureText: true,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16.0),
            TextButton(
              onPressed: () => appBloc.add(AppEventRegister(
                  email: emailController.text,
                  password: passwordController.text)),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
              child: const Text('Register'),
            ),
            const SizedBox(height: 16.0),
            Text(
              'OR',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            TextButton(
              onPressed: () => appBloc.add(const AppEventGoToLogin()),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                foregroundColor: Theme.of(context).colorScheme.primary,
              ),
              child: const Text('Login instead'),
            ),
          ],
        ),
      ),
    ));
  }
}
