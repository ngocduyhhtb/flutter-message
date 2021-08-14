import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chat_app/repository/user/user_repository.dart';
import 'package:chat_app/utils/uiUtil/constant.dart';
import 'package:chat_app/utils/uiUtil/flutter_secure_storage.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'constant.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

final SecureStorage _secureStorage = GetIt.I.get<SecureStorage>();

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository _userRepository;
  final _logger = Logger();

  AuthenticationBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(AuthenticationInitial());

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is Started) {
      yield* _mapAppStartedToState();
    } else if (event is GoogleLoggedIn) {
      yield* _mapGoogleLoggedInToState();
    } else if (event is LoggedOut) {
      yield* _mapLoggedOutToState();
    } else if (event is EmailLoggedIn) {
      yield* _mapEmailLoggedInToState();
    }
  }

  Stream<AuthenticationState> _mapAppStartedToState() async* {
    final isSignIn = await _userRepository.isGoogleSignedIn();
    try {
      if (isSignIn) {
        yield AuthenticationSuccess(type: GOOGLE_LOGGED_IN);
      } else {
        yield AuthenticationFailure();
      }
    } catch (_) {
      yield AuthenticationFailure();
    }
  }

  Stream<AuthenticationState> _mapGoogleLoggedInToState() async* {
    yield AuthenticationSuccess(type: GOOGLE_LOGGED_IN);
  }

  Stream<AuthenticationState> _mapLoggedOutToState() async* {
    await _secureStorage.deleteValue(App.SECURE_STORAGE_ACCESS_TOKEN);
    await _secureStorage.deleteValue(App.SECURE_STORAGE_EMAIL);
    await _secureStorage.deleteValue(App.SECURE_STORAGE_DISPLAY_NAME);
    await _secureStorage.deleteValue(App.SECURE_STORAGE_USER_PHOTO_URL);
    _logger.d(
      _secureStorage.readValue(App.SECURE_STORAGE_ACCESS_TOKEN),
      _secureStorage.readValue(App.SECURE_STORAGE_EMAIL),
    );
    await _userRepository.signOut();
    yield AuthenticationFailure();
  }

  Stream<AuthenticationState> _mapEmailLoggedInToState() async* {
    yield AuthenticationSuccess(type: EMAIL_LOGGED_IN);
  }
}
