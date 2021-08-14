import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chat_app/utils/uiUtil/constant.dart';
import 'package:chat_app/utils/uiUtil/hex_color_to_RGBA.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'theme_event.dart';

part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState.Initial());

  @override
  Stream<ThemeState> mapEventToState(
    ThemeEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if (event is ChangedDarkMode) {
      yield* _mapChangedDarkModeToState();
    } else if (event is ChangedToLightMode) {
      yield* _mapChangedToDarkModeToState();
    } else if (event is ToggleTheme){
      yield* _mapToggleThemeToState();
    }
  }

  Stream<ThemeState> _mapChangedDarkModeToState() async* {
    yield ThemeState.DarkMode();
  }

  Stream<ThemeState> _mapChangedToDarkModeToState() async* {
    yield ThemeState.LightMode();
  }

  Stream<ThemeState> _mapToggleThemeToState() async*{

  }
}
