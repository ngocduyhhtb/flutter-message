import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chat_app/utils/uiUtil/constant.dart';
import 'package:chat_app/utils/uiUtil/flutter_secure_storage.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

part 'user_event.dart';

part 'user_state.dart';

final SecureStorage _secureStorage = GetIt.I.get<SecureStorage>();

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserState.initial());
  final _logger = Logger();

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is LoadUser) {
      yield* _mapLoadUserToState();
    } else if (event is UpdateUser) {
      yield* _mapUpdateUserToState();
    } else if (event is DeleteUser) {
      yield* _mapDeleteUserToState();
    }
  }

  Stream<UserState> _mapLoadUserToState() async* {
    yield UserState.isLoading();
    try {
      var displayName =
          await _secureStorage.readValue(App.SECURE_STORAGE_DISPLAY_NAME);
      var userEmail = await _secureStorage.readValue(App.SECURE_STORAGE_EMAIL);
      var photoUrl =
          await _secureStorage.readValue(App.SECURE_STORAGE_USER_PHOTO_URL);
      yield UserState.isSuccess(
          displayName: displayName,
          userEmail: userEmail,
          userPhotoUrl: photoUrl);
    } catch (error) {
      _logger.e(error);
      yield UserState.isFailure();
    }
  }

  Stream<UserState> _mapUpdateUserToState() async* {}

  Stream<UserState> _mapDeleteUserToState() async* {
    try {
      await _secureStorage.deleteValue(App.SECURE_STORAGE_EMAIL);
      yield UserState.isFailure();
    } catch (error) {
      _logger.e(error);
    }
  }
}
