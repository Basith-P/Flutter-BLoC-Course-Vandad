import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:meta/meta.dart';

import '../auth/auth_errors.dart';
import '../utils/extensions.dart';
import '../utils/functions/upload_images.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(const AppStateLoggedOut()) {
    on<AppEventInitialize>(_onInitialize);
    on<AppEventRegister>(_onRegister);
    on<AppEventGoToRegistration>(_onGoToRegistration);
    on<AppEventGoToLogin>(_onInitialize);
    on<AppEventLogIn>(_onLogIn);
    on<AppEventLogOut>(_onLogOut);
    on<AppEventDeleteAccount>(_onDeleteAccount);
    on<AppEventUploadImage>(_onUploadImage);
  }

  _onInitialize(event, emit) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      emit(const AppStateLoggedOut());
      return;
    }

    final images = await getImages(user.uid);
    emit(AppStateLoggedIn(
      isLoading: false,
      user: user,
      images: images,
    ));
  }

  _onGoToRegistration(event, emit) async {
    emit(const AppStateInRegistrationView());
  }

  _onRegister(event, emit) async {
    emit(const AppStateInRegistrationView(isLoading: true));

    try {
      final userCreds = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: event.email, password: event.password);
      emit(AppStateLoggedIn(user: userCreds.user!, images: const []));
    } on FirebaseAuthException catch (e) {
      emit(AppStateInRegistrationView(authError: AuthError.from(e)));
      return;
    } catch (e) {
      emit(const AppStateInRegistrationView(authError: AuthErrorUnknown()));
      return;
    }
  }

  _onLogIn(event, emit) async {
    emit(const AppStateLoggedOut(isLoading: true));

    try {
      final userCreds = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: event.email, password: event.password);
      final images = await getImages(userCreds.user!.uid);
      emit(AppStateLoggedIn(user: userCreds.user!, images: images));
    } on FirebaseAuthException catch (e) {
      emit(AppStateLoggedOut(authError: AuthError.from(e)));
      return;
    } catch (e) {
      emit(const AppStateLoggedOut(authError: AuthErrorUnknown()));
      return;
    }
  }

  _onLogOut(event, emit) async {
    final user = state.user;
    if (user == null) {
      emit(const AppStateLoggedOut());
      return;
    }

    emit(AppStateLoggedIn(
      isLoading: true,
      user: user,
      images: state.images ?? [],
    ));

    try {
      await FirebaseAuth.instance.signOut();
      emit(const AppStateLoggedOut());
    } on FirebaseAuthException catch (e) {
      emit(AppStateLoggedIn(
        isLoading: false,
        user: user,
        images: state.images ?? [],
        authError: AuthError.from(e),
      ));
      return;
    } catch (e) {
      emit(AppStateLoggedIn(
        isLoading: false,
        user: user,
        images: state.images ?? [],
        authError: const AuthErrorUnknown(),
      ));
      return;
    }
  }

  _onDeleteAccount(event, emit) async {
    final user = state.user;
    if (user == null) {
      emit(const AppStateLoggedOut());
      return;
    }

    emit(AppStateLoggedIn(
      isLoading: true,
      user: user,
      images: state.images ?? [],
    ));

    try {
      final folder = FirebaseStorage.instance.ref(user.uid);
      await folder.delete();
      await user.delete();
      FirebaseAuth.instance.signOut();
      emit(const AppStateLoggedOut());
    } on FirebaseAuthException catch (e) {
      emit(AppStateLoggedIn(
        isLoading: false,
        user: user,
        images: state.images ?? [],
        authError: AuthError.from(e),
      ));
      return;
    } catch (e) {
      emit(AppStateLoggedIn(
        isLoading: false,
        user: user,
        images: state.images ?? [],
        authError: const AuthErrorUnknown(),
      ));
      return;
    }

    await user.delete();
    emit(const AppStateLoggedOut());
  }

  _onUploadImage(event, emit) async {
    final user = state.user;
    if (user == null) {
      emit(const AppStateLoggedOut());
      return;
    }

    emit(AppStateLoggedIn(
      isLoading: true,
      user: user,
      images: state.images ?? [],
    ));

    await uploadImage(user.uid, event.imagePath);
    final images = await getImages(user.uid);
    emit(AppStateLoggedIn(
      isLoading: false,
      user: user,
      images: images,
    ));
  }

  Future<List<Reference>> getImages(String uid) {
    return FirebaseStorage.instance
        .ref('users/$uid/images')
        .listAll()
        .then((result) => result.items);
  }
}
