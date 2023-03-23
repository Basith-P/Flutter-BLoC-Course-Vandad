import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../dialogs/log_out_dialog.dart';
import 'app_bloc.dart';

enum MenuAction { logout, deleteAccount }

class MainPopupMenuButton extends StatelessWidget {
  const MainPopupMenuButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appBloc = context.read<AppBloc>();

    return PopupMenuButton<MenuAction>(
      onSelected: (action) async {
        switch (action) {
          case MenuAction.logout:
            final shouldLogOut = await showLogOutDialog(context);
            if (shouldLogOut == true) {
              appBloc.add(const AppEventLogOut());
            }
            break;
          case MenuAction.deleteAccount:
            final shouldDeleteAccount = await showLogOutDialog(context);
            if (shouldDeleteAccount == true) {
              appBloc.add(const AppEventDeleteAccount());
            }

            break;
        }
      },
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: MenuAction.logout,
          child: Text('Logout'),
        ),
        const PopupMenuItem(
          value: MenuAction.deleteAccount,
          child: Text('Delete Account'),
        ),
      ],
    );
  }
}
