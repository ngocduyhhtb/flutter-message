part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class LoadUser extends UserEvent {}

class DeleteUser extends UserEvent {}

class UpdateUser extends UserEvent {}
