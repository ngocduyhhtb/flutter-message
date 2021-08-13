import 'package:chat_app/utils/uiUtil/constant.dart';
import 'package:chat_app/views/search/search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

appBarMain(
    BuildContext context, String title, bool showBackButton, bool action) {
  return AppBar(
      title: Text(title),
      automaticallyImplyLeading: false,
      elevation: 0,
      actions: action
          ? [
              IconButton(
                onPressed: () {
                  showSearch(context: context, delegate: SearchView());
                },
                icon: FaIcon(MaterialIcons.search),
              )
            ]
          : null);
}
