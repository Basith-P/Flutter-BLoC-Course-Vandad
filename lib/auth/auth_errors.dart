import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show immutable;

const Map<String, AuthError> authErrorMapping = {
  'user-not-found': AuthErrorUserNotFound(),
  'weak-password': AuthErrorWeakPassword(),
  'invalid-email': AuthErrorInvalidEmail(),
  'operation-not-allowed': AuthErrorOperationNotAllowed(),
  'email-already-in-use': AuthErrorEmailAlreadyInUse(),
  'requires-recent-login': AuthErrorRequiresRecentLogin(),
  'no-current-user': AuthErrorNoCurrentUser(),
};

@immutable
class AuthError {
  final String title;
  final String message;

  const AuthError({required this.title, this.message = ''});

  factory AuthError.from(FirebaseAuthException e) {
    return authErrorMapping[e.code.trim().toLowerCase()] ??
        const AuthErrorUnknown();
  }
}

@immutable
class AuthErrorUnknown extends AuthError {
  const AuthErrorUnknown()
      : super(
          title: 'Unknown Error',
          message: 'An error occurred. Please try again later.',
        );
}

// auth/no-current-user

@immutable
class AuthErrorNoCurrentUser extends AuthError {
  const AuthErrorNoCurrentUser()
      : super(
          title: 'No current user!',
          message: 'No current user with this information was found!',
        );
}

// auth/requires-recent-login

@immutable
class AuthErrorRequiresRecentLogin extends AuthError {
  const AuthErrorRequiresRecentLogin()
      : super(
          title: 'Requires recent login',
          message:
              'You need to log out and log back in again in order to perform this operation',
        );
}

// auth/operation-not-allowed

@immutable
class AuthErrorOperationNotAllowed extends AuthError {
  const AuthErrorOperationNotAllowed()
      : super(
          title: 'Operation not allowed',
          message: 'You cannot register using this method at this moment!',
        );
}

// auth/user-not-found

@immutable
class AuthErrorUserNotFound extends AuthError {
  const AuthErrorUserNotFound()
      : super(
          title: 'User not found',
          message: 'The given user was not found on the server!',
        );
}

// auth/weak-password

@immutable
class AuthErrorWeakPassword extends AuthError {
  const AuthErrorWeakPassword()
      : super(
          title: 'Weak password',
          message:
              'Please choose a stronger password consisting of more characters!',
        );
}

// auth/invalid-email

@immutable
class AuthErrorInvalidEmail extends AuthError {
  const AuthErrorInvalidEmail()
      : super(
          title: 'Invalid email',
          message: 'Please double check your email and try again!',
        );
}

// auth/email-already-in-use

@immutable
class AuthErrorEmailAlreadyInUse extends AuthError {
  const AuthErrorEmailAlreadyInUse()
      : super(
          title: 'Email already in use',
          message: 'Please choose another email to register with!',
        );
}
