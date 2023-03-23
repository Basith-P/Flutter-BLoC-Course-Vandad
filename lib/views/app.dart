import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/app_bloc.dart';
import '../dialogs/show_auth_error.dart';
import '../loading/loading_overlay.dart';
import '../utils/global/keys.dart';
import 'login_view.dart';
import 'photo_gallery_view.dart';
import 'register_view.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: BlocProvider(
        create: (_) => AppBloc()..add(const AppEventInitialize()),
        child: MaterialApp(
            title: 'Photo Storage',
            navigatorKey: navigatorKey,
            theme: ThemeData.light(useMaterial3: true),
            darkTheme: ThemeData.dark(useMaterial3: true).copyWith(
              colorScheme:
                  ThemeData.dark(useMaterial3: true).colorScheme.copyWith(
                        primary: Colors.yellow,
                        onPrimary: Colors.black87,
                        secondary: Colors.orange,
                        onSecondary: Colors.black87,
                      ),
            ),
            themeMode: ThemeMode.system,
            debugShowCheckedModeBanner: false,
            home:
                BlocConsumer<AppBloc, AppState>(listener: (context, appState) {
              if (appState.isLoading) {
                LoadingScreen.instance()
                    .show(context: context, text: 'Loading...');
              } else {
                LoadingScreen.instance().hide();
              }

              final authError = appState.authError;
              if (authError != null) {
                showAuthError(authError: authError, context: context);
              }
            }, builder: (_, appState) {
              if (appState is AppStateLoggedOut) {
                return const LoginView();
              } else if (appState is AppStateInRegistrationView) {
                return const RegisterView();
              } else if (appState is AppStateLoggedIn) {
                return const PhotoGalleryView();
              } else {
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            })),
      ),
    );
  }
}
