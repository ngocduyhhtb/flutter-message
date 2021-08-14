import 'package:bot_toast/bot_toast.dart';
import 'package:chat_app/repository/user/user_repository.dart';
import 'package:chat_app/routes/appPages.dart';
import 'package:chat_app/utils/uiUtil/constant.dart';
import 'package:chat_app/utils/uiUtil/dimiss_keyboard.dart';
import 'package:chat_app/services/locator_service.dart';
import 'package:chat_app/views/authentication/signin.dart';
import 'package:chat_app/views/message_room/chat_room.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telephony/telephony.dart';

import 'bloc/authentication_bloc/authentication_bloc.dart';
import 'bloc/simple_bloc_observer.dart';
import 'bloc/theme/theme_bloc.dart';

backgroundMessageHandler(SmsMessage message) async {
  //Handle background message
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
  };
  await setupLocator();
  Bloc.observer = SimpleBlocObserver();
  final UserRepository userRepository = UserRepository();
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  final _userRepository = UserRepository();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ThemeBloc>(
      create: (context) => ThemeBloc(),
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          return BlocProvider<AuthenticationBloc>(
            create: (context) =>
                AuthenticationBloc(userRepository: _userRepository)
                  ..add(Started()),
            child: DismissKeyboard(
              child: MaterialApp(
                builder: BotToastInit(),
                title: 'Flutter Chat App',
                debugShowCheckedModeBanner: false,
                theme: themeState.themeData,
                home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                  builder:
                      (BuildContext context, AuthenticationState authState) {
                    if (authState is AuthenticationFailure) {
                      return SignIn(
                        userRepository: _userRepository,
                      );
                    }
                    if (authState is AuthenticationSuccess) {
                      return ChatRoom();
                    }
                    return Scaffold(
                      appBar: AppBar(),
                      backgroundColor: App.primaryColor,
                      body: Container(
                        child: Center(
                          child: Text("Loading"),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
