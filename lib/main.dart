import 'package:eat_well_review/route_generator.dart';
import 'package:eat_well_review/widgets/misc/bloc_wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/user/user_bloc.dart';
import 'bloc/user/user_state.dart';
import 'constants.dart';
import 'widgets/screens/login/login_screen.dart';
import 'widgets/screens/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    _setUpStatusBarAndOrientation();
    return FireBlocWrapper(
      child: BlocListener<UserBloc, UserState>(
        listenWhen: (previous, current) =>
            previous is UserAuthenticated && current is UserUnauthenticated,
        listener: (context, state) =>
            Navigator.pushNamed(context, LoginScreen.routeName),
        child: MaterialApp(
          title: kAppName,
          theme: _getThemeData(),
          initialRoute: SplashScreen.routeName,
          onGenerateRoute: RouteGenerator.generateRoute,
        ),
      ),
    );
  }

  _setUpStatusBarAndOrientation() {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  ThemeData _getThemeData() {
    return ThemeData(
      primaryColor: kPrimaryColor,
      primaryColorDark: kPrimaryColorDark,
      primaryColorLight: kPrimaryColorLight,
      accentColor: kAccentColor,
      textTheme: TextTheme().apply(
        bodyColor: kTextColorPrimary,
        displayColor: kTextColorPrimary,
      ),
      fontFamily: 'Quicksand',
      iconTheme: IconThemeData(color: Colors.white),
      inputDecorationTheme: InputDecorationTheme(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide(width: 1.5, color: kTextColorSecondary),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide(width: 2.5, color: kPrimaryColor),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide(width: 2.5, color: Colors.red),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide(width: 2.5, color: Colors.red),
        ),
        contentPadding: EdgeInsets.zero,
      ),
      buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        textTheme: ButtonTextTheme.primary,
        buttonColor: kPrimaryColorDark,
      ),
      primaryIconTheme: IconThemeData(color: Colors.white),
      accentIconTheme: IconThemeData(color: Colors.white),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        foregroundColor: Colors.white,
        backgroundColor: kAccentColor,
      ),
      dividerTheme: DividerThemeData(
        color: kDividerColor,
        space: 0,
        thickness: 1,
      ),
      hintColor: kTextColorSecondary,
      cursorColor: kPrimaryColor,
      textSelectionColor: kPrimaryColorLight,
      textSelectionHandleColor: kPrimaryColorDark,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }
}