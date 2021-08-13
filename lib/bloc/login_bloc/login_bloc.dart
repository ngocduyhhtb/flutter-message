import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:chat_app/repository/user/user_repository.dart';
import 'package:chat_app/utils/uiUtil/constant.dart';
import 'package:chat_app/utils/uiUtil/flutter_secure_storage.dart';
import 'package:chat_app/utils/uiUtil/validator.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

part 'login_state.dart';

part 'login_event.dart';

final SecureStorage _secureStorage = GetIt.I.get<SecureStorage>();

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository _userRepository;
  final _logger = Logger();

  LoginBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(LoginState.initial());

  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginWithCredentialsPressed) {
      yield* _mapLoginWithCredentialsPressedToState(
          email: event.email, password: event.password);
    } else if (event is LoginWithGoogle) {
      yield* _mapLoginWithGoogleToState();
    }
  }

  Stream<LoginState> _mapLoginWithCredentialsPressedToState(
      {required String email, required String password}) async* {
    yield LoginState.loading();
    try {
      await _userRepository.signInWithCredentials(email, password);
      yield LoginState.success();
    } catch (error) {
      _logger.e(error);
      yield LoginState.failure();
    }
  }

  Stream<LoginState> _mapLoginWithGoogleToState() async* {
    yield LoginState.loading();
    try {
      await _userRepository.signInWithGoogle().then((value) {
        // _secureStorage.writeValue(
        //     App.SECURE_STORAGE_USER_PHOTO_URL, value.);
        _secureStorage.writeValue(App.SECURE_STORAGE_EMAIL, value.email);
      });
      yield LoginState.success();
    } catch (error) {
      _logger.e(error);
      yield LoginState.failure();
    }
  }
}
