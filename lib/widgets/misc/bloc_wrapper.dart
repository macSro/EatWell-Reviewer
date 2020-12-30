import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eat_well_review/bloc/inquiries/inquiries_bloc.dart';
import 'package:eat_well_review/bloc/inquiry/inquiry_bloc.dart';
import 'package:eat_well_review/bloc/user/user_bloc.dart';
import 'package:eat_well_review/bloc/user/user_event.dart';
import 'package:eat_well_review/repositories/inquiries_repository.dart';
import 'package:eat_well_review/repositories/inquiry_repository.dart';
import 'package:eat_well_review/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FireBlocWrapper extends StatelessWidget {
  final Widget child;

  FireBlocWrapper({@required this.child});

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    UserRepository userRepository = UserRepository(firestore: firestore);
    InquiriesRepository inquiriesRepository =
        InquiriesRepository(firestore: firestore);
    InquiryRepository inquiryRepository =
        InquiryRepository(firestore: firestore);
        
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UserBloc(
            repository: userRepository,
          )..add(AppStarted()),
        ),
        BlocProvider(
          create: (context) => InquiriesBloc(
            repository: inquiriesRepository,
          ),
        ),
        BlocProvider(
          create: (context) => InquiryBloc(
            repository: inquiryRepository,
          ),
        ),
      ],
      child: child,
    );
  }
}
