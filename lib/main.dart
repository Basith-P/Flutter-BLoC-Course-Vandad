import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'apis/login_api.dart';
import 'apis/nots_ap.dart';
import 'bloc/actions.dart';
import 'bloc/app_bloc.dart';
import 'bloc/app_state.dart';
import 'dialogs/generic_dialog.dart';
import 'dialogs/loading_dialog.dart';
import 'models.dart';
import 'strings.dart';
import 'views/iterable_list_view.dart';
import 'views/login_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final focusScope = FocusScope.of(context);
        if (!focusScope.hasPrimaryFocus && focusScope.hasFocus) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.light(useMaterial3: true),
        darkTheme: ThemeData.dark(useMaterial3: true),
        themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
        home: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppBloc(
        loginApi: LoginApi.instance,
        notesApi: NotesApi(),
      ),
      child: Scaffold(
          appBar: AppBar(
            title: const Text(appName),
          ),
          body: BlocConsumer<AppBloc, AppState>(
            listener: (context, state) {
              /// Show loading dialog
              if (state.isLoading) {
                LoadingScreen.instance()
                    .show(context: context, text: pleaseWait);
              } else {
                LoadingScreen.instance().hide();
              }

              /// Show error dialog
              final loginError = state.loginError;
              if (loginError != null) {
                showGenericDialog<bool>(
                  context: context,
                  title: loginErrorDialogTitle,
                  content: loginErrorDialogContent,
                  optionsBuilder: () => {ok: true},
                );
              }

              // if we are logged in, but we have no fetched notes, fetch them now
              if (state.isLoading == false &&
                  state.loginError == null &&
                  state.loginHandle == const LoginHandle.fooBar() &&
                  state.fetchedNotes == null) {
                context.read<AppBloc>().add(const LoadNotesAction());
              }
            },
            builder: (context, state) {
              final notes = state.fetchedNotes;
              if (notes == null) {
                return LoginView(
                  onLoginTapped: (email, password) {
                    context.read<AppBloc>().add(
                          LoginAction(
                            email: email,
                            password: password,
                          ),
                        );
                  },
                );
              } else {
                return notes.toListView();
              }
            },
          )),
    );
  }
}
