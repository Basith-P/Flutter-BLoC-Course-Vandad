import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../bloc/app_bloc.dart';

extension GetUser on AppState {
  User? get user {
    return (this as AppStateLoggedIn?)?.user;
  }
}

extension GetImages on AppState {
  List<Reference>? get images {
    return (this as AppStateLoggedIn?)?.images;
  }
}
