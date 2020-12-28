import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/user/user_bloc.dart';
import '../../bloc/user/user_state.dart';
import '../screens/login/login_screen.dart';

class MyScaffold extends StatelessWidget {
  final Widget child;

  MyScaffold({@required this.child});

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
          body: DoubleBackToCloseApp(
            child: child,
            snackBar: const SnackBar(
              content: const Text('Tap back again to exit.'),
            ),
          ),
        ),
      ),
    );
  }
}
