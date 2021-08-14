part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class LoginEmailChange extends LoginEvent {
  final String email;

  LoginEmailChange({required this.email});

  @override
  // TODO: implement props
  List<Object> get props => [this.email];
}

class LoginPasswordChanged extends LoginEvent {
  final String password;

  LoginPasswordChanged({required this.password});

  @override
  List<Object> get props => [this.password];
}

class LoginWithEmail extends LoginEvent {
  final String email;
  final String password;

  LoginWithEmail({required this.email, required this.password});

  @override
  List<Object> get props => [this.email, this.password];
}

class LoginWithGoogle extends LoginEvent {}
