import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/user/user_bloc.dart';
import '../../../bloc/user/user_event.dart';
import '../../../constants.dart';
import '../../../tools.dart';
import '../../misc/icon_text.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isError = false;
  bool isButtonPressed = false;
  bool focus1 = false;
  bool focus2 = false;

  @override
  void initState() {
    emailController.addListener(() {
      setState(() {
        if (emailController.text.isNotEmpty) {
          focus1 = true;
        }
        focus2 = false;
      });
    });
    passwordController.addListener(() {
      setState(() {
        if (passwordController.text.isNotEmpty) {
          focus2 = true;
        }
        focus1 = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      onChanged: () {
        isButtonPressed = false;
        if (isError) {
          _formKey.currentState.validate();
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: emailController,
            validator: (val) {
              if (!isButtonPressed) {
                return null;
              }
              isError = true;
              final message = Tools.validateEmail(val);
              if (message != null) {
                return message;
              } else {
                isError = false;
                return null;
              }
            },
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.mail_outline_rounded),
              hintText: 'Enter your email',
              suffixIcon: focus1
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        setState(() {
                          focus1 = false;
                        });
                        emailController.clear();
                      },
                    )
                  : null,
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: passwordController,
            validator: (val) {
              if (!isButtonPressed) {
                return null;
              }
              isError = true;
              final message = val.isEmpty ? 'Enter a password.' : null;
              if (message != null) {
                return message;
              } else {
                isError = false;
                return null;
              }
            },
            obscureText: true,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.lock),
              hintText: 'Enter your password',
              suffixIcon: focus2
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        setState(() {
                          focus2 = false;
                        });
                        passwordController.clear();
                      },
                    )
                  : null,
            ),
          ),
          const SizedBox(height: 24),
          RaisedButton(
            onPressed: () => _processLogin(context),
            color: kPrimaryColor,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: IconText(
              iconFirst: false,
              squeeze: true,
              icon: Icon(
                Icons.arrow_forward_rounded,
                size: 28,
              ),
              text: Text(
                'Sign In',
                style: TextStyle().copyWith(fontSize: 24),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _processLogin(context) {
    isButtonPressed = true;
    if (_formKey.currentState.validate()) {
      BlocProvider.of<UserBloc>(context).add(
        SignIn(
          email: emailController.text.toLowerCase(),
          password: passwordController.text,
        ),
      );
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
