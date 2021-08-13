import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:chat_app/model/user_email.dart';
import 'package:chat_app/repository/user/user_repository.dart';
import 'package:chat_app/utils/network_util/api_client.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'register_state.dart';

part 'register_event.dart';

final ApiClient _apiClient = GetIt.instance.get<ApiClient>();

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserRepository _userRepository;
  final _logger = Logger();

  RegisterBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(RegisterState.initial());

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if (event is RegisterSubmitted) {
      yield* _mapRegisterSubmittedToState(
          email: event.email, password: event.password);
    }
  }

  Stream<RegisterState> _mapRegisterSubmittedToState(
      {required String email, required String password}) async* {
    yield RegisterState.loading();
    try {
      await _apiClient.registerUser(
          userEmail: new UserEmail(email: email, password: password));
      yield RegisterState.success();
    } catch (error) {
      _logger.e(error);
      RegisterState.failure();
    }
  }
}
