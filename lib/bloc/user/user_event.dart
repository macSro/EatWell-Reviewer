import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class UserEvent extends Equatable {}

class AppStarted extends UserEvent {
  @override
  List<Object> get props => [];
}

class SignIn extends UserEvent {
  final String email;
  final String password;

  SignIn({@required this.email, @required this.password});

  @override
  List<Object> get props => [email, password];
}

class SignOut extends UserEvent {
  @override
  List<Object> get props => [];
}
