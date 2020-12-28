import 'package:eat_well_review/bloc/user/user_bloc.dart';
import 'package:eat_well_review/bloc/user/user_state.dart';
import 'package:eat_well_review/widgets/misc/loading.dart';
import 'package:eat_well_review/widgets/screens/error/error_screen.dart';
import 'package:eat_well_review/widgets/screens/inquiries/inquiries_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';

import '../../../constants.dart';
import 'login_form.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/login';

  @override
  Widget build(BuildContext context) {
    return Material(
      child: BlocListener<UserBloc, UserState>(
        listenWhen: (previous, current) =>
            previous is UserLoading && current is UserAuthenticated,
        listener: (context, state) => _navigateToInquiriesScreen(context),
        child: BlocListener<UserBloc, UserState>(
          listenWhen: (previous, current) =>
              previous is UserLoading && current is UserAuthenticationFailed,
          listener: (context, state) => Navigator.pushNamed(
            context,
            ErrorScreen.routeName,
            arguments: kUserAuthenticationFailedMessage,
          ),
          child: BlocBuilder<UserBloc, UserState>(
            builder: (context, state) => state is UserLoading
                ? LoadingView(text: 'Authentication in progress...')
                : _getContent(context),
          ),
        ),
      ),
    );
  }

  Widget _getContent(context) {
    return Stack(
      children: [
        SvgPicture.asset(
          'assets/images/loginBackground.svg',
          fit: BoxFit.fill,
          width: double.infinity,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/images/xo.svg',
                height: 64,
              ),
              const SizedBox(height: 16),
              Text(
                'Welcome to',
                style: Theme.of(context).textTheme.headline5.copyWith(
                      color: kPrimaryColorDark,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Text(
                'EatWell XO Reviewer!',
                style: Theme.of(context).textTheme.headline5.copyWith(
                      color: kPrimaryColorDark,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 24),
              KeyboardAvoider(
                child: LoginForm(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  _navigateToInquiriesScreen(context) {
    Navigator.of(context).pushReplacementNamed(InquiriesScreen.routeName);
    //BlocProvider.of<InquiriesBloc>(context).add(FetchInquiries());
  }
}
