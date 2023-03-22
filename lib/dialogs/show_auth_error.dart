import 'package:flutter/material.dart' show BuildContext;

import '../auth/auth_errors.dart';
import 'generic_dialog.dart';

Future<void> showAuthError({
  required AuthError authError,
  required BuildContext context,
}) {
  return showGenericDialog<void>(
    context: context,
    title: authError.title,
    content: authError.message,
    optionsBuilder: () => {'OK': true},
  );
}
