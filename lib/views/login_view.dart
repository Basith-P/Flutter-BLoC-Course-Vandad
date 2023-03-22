import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../utils/if_debugging.dart';
import '../utils/vars/input_decorations.dart';

class LoginView extends HookWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final emailController =
        useTextEditingController(text: 'abc@xyz.com'.ifDebugging);
    final passwordController =
        useTextEditingController(text: 'foobar'.ifDebugging);

    return Scaffold(
        appBar: AppBar(title: const Text('Login')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
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
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  child: const Text('Login'),
                ),
              ],
            ),
          ),
        ));
  }
}
