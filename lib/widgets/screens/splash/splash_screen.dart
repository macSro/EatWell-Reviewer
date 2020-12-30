import 'package:eat_well_review/bloc/inquiries/inquiries_bloc.dart';
import 'package:eat_well_review/bloc/inquiries/inquiries_event.dart';
import 'package:eat_well_review/bloc/user/user_bloc.dart';
import 'package:eat_well_review/bloc/user/user_state.dart';
import 'package:eat_well_review/widgets/screens/inquiries/inquiries_screen.dart';
import 'package:eat_well_review/widgets/screens/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants.dart';

class SplashScreen extends StatelessWidget {
  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listenWhen: (previous, current) => previous is UserInitial && !(current is UserInitial),
      listener: (context, state) {
        if (state is UserUnauthenticated) {
          Navigator.pushReplacementNamed(context, LoginScreen.routeName);
        } else {
          //State has to be UserAuthenticated here.
          Navigator.pushReplacementNamed(context, InquiriesScreen.routeName);
          BlocProvider.of<InquiriesBloc>(context).add(FetchInquiries());
        }
      },
      child: Container(
        color: kPrimaryColorDark,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/images/logo.svg',
              height: 200,
            ),
            const SizedBox(height: 32),
            Text(
              'EatWell XO Reviewer',
              style: Theme.of(context).textTheme.headline4.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: [
                  Shadow(
                    offset: Offset(2.5, 2.5),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}