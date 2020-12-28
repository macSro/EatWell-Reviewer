import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eat_well_review/bloc/user/user_bloc.dart';
import 'package:eat_well_review/bloc/user/user_event.dart';
import 'package:eat_well_review/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FireBlocWrapper extends StatelessWidget {
  final Widget child;

  FireBlocWrapper({@required this.child});

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    UserRepository userRepository = UserRepository();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UserBloc(
            repository: userRepository,
          )..add(AppStarted()),
        ),
      ],
      child: child,
    );
  }
}
