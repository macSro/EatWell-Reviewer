import 'package:eat_well_review/widgets/screens/inquiry/inquiry_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'widgets/screens/inquiries/inquiries_screen.dart';
import 'widgets/screens/login/login_screen.dart';
import 'widgets/screens/splash/splash_screen.dart';
import 'widgets/screens/error/error_screen.dart';

typedef Widget _ScreenBuilder(BuildContext context);

final Map<String, _ScreenBuilder> _routeBuilders = {
  SplashScreen.routeName: (context) => SplashScreen(),
  LoginScreen.routeName: (context) => LoginScreen(),
  InquiriesScreen.routeName: (context) => InquiriesScreen(),
  InquiryScreen.routeName: (context) => InquiryScreen(),
};

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    if (_routeBuilders.containsKey(settings.name)) {
      final routeBuilder = _routeBuilders[settings.name];
      return CupertinoPageRoute(builder: routeBuilder, settings: settings);
    } else if (settings.name == ErrorScreen.routeName) {
      return MaterialPageRoute(
          builder: (context) => settings.arguments != null
              ? ErrorScreen(message: settings.arguments)
              : ErrorScreen(),
          settings: settings);
    } else {
      return _errorRoute(settings);
    }
  }

  static Route<dynamic> _errorRoute(settings) {
    return MaterialPageRoute(
      builder: (_) {
        return Scaffold(
          body: Center(
            child: Text(
              'Wrong route...',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        );
      },
      settings: settings,
    );
  }
}
