part of 'app_bloc.dart';

@immutable
abstract class AppState extends Equatable {
  final bool isLoading;
  final AuthError? authError;

  const AppState({this.isLoading = false, this.authError});
}

@immutable
class AppStateLoggedIn extends AppState {
  final User user;
  final List<Reference> images;

  const AppStateLoggedIn({
    required this.user,
    required this.images,
    bool isLoading = false,
    AuthError? authError,
  }) : super(isLoading: isLoading, authError: authError);

  @override
  List<Object?> get props => [user, images, isLoading, authError];

  @override
  String toString() => 'AppStateLoggedIn, images: ${images.length}}';
}

@immutable
class AppStateLoggedOut extends AppState {
  const AppStateLoggedOut({
    bool isLoading = false,
    AuthError? authError,
  }) : super(isLoading: isLoading, authError: authError);

  @override
  List<Object?> get props => [isLoading, authError];

  @override
  String toString() => 'AppStateLoggedOut, authError: $authError';
}

@immutable
class AppStateInRegistrationView extends AppState {
  const AppStateInRegistrationView({
    bool isLoading = false,
    AuthError? authError,
  }) : super(isLoading: isLoading, authError: authError);

  @override
  List<Object?> get props => [isLoading, authError];

  @override
  String toString() => 'AppStateRegistration, authError: $authError';
}
