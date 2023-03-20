import 'package:flutter/foundation.dart' show immutable;

import '../models.dart';

@immutable
abstract class LoginApiProtocol {
  const LoginApiProtocol();

  Future<LoginHandle?> login({
    required String email,
    required String password,
  });
}

@immutable
class LoginApi implements LoginApiProtocol {
  /// Singleton instance
  const LoginApi._();
  static const instance = LoginApi._();
  factory LoginApi() => instance;

  @override
  Future<LoginHandle?> login({
    required String email,
    required String password,
  }) =>
      Future.delayed(
        const Duration(seconds: 3),
        () => email == 'foo@bar.com' && password == 'foobar',
      ).then((isCorrect) => isCorrect ? const LoginHandle.fooBar() : null);
}
