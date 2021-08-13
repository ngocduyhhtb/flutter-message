import 'package:chat_app/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:chat_app/bloc/theme/theme_bloc.dart';
import 'package:chat_app/bloc/user_bloc/user_bloc.dart';
import 'package:chat_app/repository/user/user_repository.dart';
import 'package:chat_app/utils/uiUtil/constant.dart';
import 'package:chat_app/utils/uiUtil/flutter_secure_storage.dart';
import 'package:chat_app/widgets/widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ThemeBloc>(
      create: (context) => ThemeBloc(),
      child: BlocConsumer<ThemeBloc, ThemeState>(
        listener: (context, themeState) {},
        builder: (context, themeState) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Profile"),
              automaticallyImplyLeading: false,
              elevation: 0,
              actions: <Widget>[
                PopupMenuButton(
                  elevation: 0,
                  child: Center(
                    child: Icon(Icons.more_horiz),
                  ),
                  itemBuilder: (BuildContext context) {
                    return List.generate(
                      1,
                      (index) {
                        return PopupMenuItem(
                          child: Row(
                            children: [
                              Center(
                                child: Text(themeState.isDarkTheme
                                    ? "Switch Light Mode"
                                    : "Switch Dark Mode"),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
            body: BlocProvider<UserBloc>(
              create: (context) => UserBloc()
                ..add(
                  LoadUser(),
                ),
              child: BlocBuilder<UserBloc, UserState>(
                builder: (context, userState) {
                  return Container(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Stack(
                            children: <Widget>[
                              Center(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: FadeInImage.assetNetwork(
                                    image: FirebaseAuth
                                        .instance.currentUser!.photoURL
                                        .toString(),
                                    placeholder: 'assets/images/logo.png',
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
                            child: Text(
                              FirebaseAuth.instance.currentUser!.displayName
                                  .toString(),
                            ),
                          ),
                          Container(
                            child: ElevatedButton(
                              onPressed: () {
                                print("CAKCMasc");
                                BlocProvider.of<ThemeBloc>(context)
                                    .add(ChangedToLightMode());
                              },
                              child: Text(themeState.isDarkTheme
                                  ? "Switch Light Mode"
                                  : "Switch Dark Mode"),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
                            child: Text(userState.userEmail),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
                            child: ElevatedButton.icon(
                              onPressed: () {
                                BlocProvider.of<AuthenticationBloc>(context)
                                    .add(
                                  LoggedOut(),
                                );
                              },
                              icon: Icon(MaterialIcons.keyboard_tab),
                              label: Text("Logout"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
