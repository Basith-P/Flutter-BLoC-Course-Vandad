import 'package:bloc/bloc.dart';

import '../apis/login_api.dart';
import '../apis/nots_ap.dart';
import '../models.dart';
import 'actions.dart';
import 'app_state.dart';

class AppBloc extends Bloc<AppAction, AppState> {
  final LoginApiProtocol loginApi;
  final NotesApiProtocol notesApi;

  AppBloc({
    required this.loginApi,
    required this.notesApi,
  }) : super(const AppState.empty()) {
    on<LoginAction>(_onLoginAction);
    on<LoadNotesAction>(_onLoadNotesAction);
  }

  void _onLoginAction(LoginAction action, Emitter<AppState> emit) async {
    emit(const AppState(
        isLoading: true,
        loginError: null,
        loginHandle: null,
        fetchedNotes: null));

    final loginHandle =
        await loginApi.login(email: action.email, password: action.password);

    emit(AppState(
      isLoading: false,
      loginError: loginHandle == null ? LoginErrors.invalidHandle : null,
      loginHandle: loginHandle,
      fetchedNotes: null,
    ));
  }

  void _onLoadNotesAction(
      LoadNotesAction action, Emitter<AppState> emit) async {
    emit(AppState(
      isLoading: true,
      loginError: null,
      loginHandle: state.loginHandle,
      fetchedNotes: null,
    ));

    if (state.loginHandle != const LoginHandle.fooBar()) {
      emit(AppState(
        isLoading: false,
        loginError: LoginErrors.invalidHandle,
        loginHandle: state.loginHandle,
        fetchedNotes: null,
      ));
      return;
    }

    final notes = await notesApi.getNotes(loginHandle: state.loginHandle!);

    emit(AppState(
      isLoading: false,
      loginError: null,
      loginHandle: state.loginHandle,
      fetchedNotes: notes,
    ));
  }
}
