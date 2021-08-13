part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class Started extends AuthenticationEvent {}

class GoogleLoggedIn extends AuthenticationEvent {}

class GoogleLoggedOut extends AuthenticationEvent {}

class EmailLoggedIn extends AuthenticationEvent {}

class LoggedOut extends AuthenticationEvent {}
