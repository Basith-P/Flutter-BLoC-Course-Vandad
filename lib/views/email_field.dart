import 'package:flutter/material.dart';

import '../strings.dart' show enterYourEmailHere;

class EmailTextField extends StatelessWidget {
  final TextEditingController emailController;

  const EmailTextField({
    Key? key,
    required this.emailController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      autocorrect: false,
      decoration: const InputDecoration(
        labelText: enterYourEmailHere,
        border: OutlineInputBorder(),
      ),
    );
  }
}
