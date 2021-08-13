part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  AuthenticationState();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationSuccess extends AuthenticationState {
  final String type;

  AuthenticationSuccess({required this.type});
}

class AuthenticationFailure extends AuthenticationState {}
