part of 'theme_bloc.dart';

abstract class ThemeEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class ChangedDarkMode extends ThemeEvent {}

class ChangedToLightMode extends ThemeEvent {}
