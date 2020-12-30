import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/user/user_bloc.dart';
import '../../bloc/user/user_state.dart';
import '../screens/login/login_screen.dart';

class MyScaffold extends StatelessWidget {
  final Widget child;
  final bool hasAppBar;
  final String title;
  final List<Widget> actions;
  final Widget floatingActionButton;
  final bool doubleBack;

  MyScaffold({
    @required this.child,
    this.hasAppBar = true,
    this.title,
    this.actions,
    this.floatingActionButton,
    this.doubleBack = true,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listenWhen: (previous, current) =>
          previous is UserLoading && current is UserUnauthenticated,
      listener: (context, state) {
        Navigator.pushReplacementNamed(context, LoginScreen.routeName);
      },
      child: SafeArea(
        child: Scaffold(
          appBar: hasAppBar
              ? AppBar(
                  title: Text(title),
                  actions: actions,
                )
              : null,
          body: doubleBack ? DoubleBackToCloseApp(
            child: child,
            snackBar: const SnackBar(
              content: const Text('Tap back again to exit.'),
            ),
          ) : child,
          floatingActionButton: floatingActionButton,
        ),
      ),
    );
  }
}
