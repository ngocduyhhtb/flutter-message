import 'dart:math';
import 'package:bot_toast/bot_toast.dart';
import 'package:chat_app/bloc/message_bloc/message_bloc.dart';
import 'package:chat_app/services/sms_service.dart';
import 'package:chat_app/utils/uiUtil/constant.dart';
import 'package:chat_app/views/message_room/message_detail.dart';
import 'package:chat_app/widgets/app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:logger/logger.dart';

class InboxMessage extends StatelessWidget {
  final List colors = [
    Colors.purpleAccent,
    Colors.green[300],
    Colors.deepOrangeAccent,
    Colors.grey
  ];
  final Random random = new Random();
  final _logger = Logger();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MessageBloc>(
      create: (context) => MessageBloc()..add(LoadInboxMessage()),
      child: BlocConsumer<MessageBloc, MessageState>(
        listener: (context, state) {
          if (state.isLoading) {
            CircularProgressIndicator();
            BotToast.showLoading();
          }
          if (state.isSuccess) {
            BotToast.closeAllLoading();
          }
        },
        builder: (context, messageState) {
          return Scaffold(
            backgroundColor: App.primaryColor,
            appBar: appBarMain(context, "Inbox", false, true),
            resizeToAvoidBottomInset: false,
            body: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.fromLTRB(0, 2, 0, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: ListView.builder(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        physics: new ClampingScrollPhysics(),
                        itemCount: messageState.listMessage.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            children: <Widget>[
                              InkWell(
                                onTap: () => {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MessageDetail(
                                              smsMessage: messageState
                                                  .listMessage
                                                  .elementAt(index),
                                              canBeReply: messageState
                                                      .listMessage
                                                      .elementAt(index)
                                                      .address
                                                      .startsWith('+84')
                                                  ? true
                                                  : false)))
                                },
                                child: Card(
                                  margin: EdgeInsets.fromLTRB(4, 2, 4, 2),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  color: App.primaryColor,
                                  elevation: 0,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      ListTile(
                                        leading: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            CircleAvatar(
                                              radius: 18,
                                              child: Icon(
                                                MaterialIcons.account_circle,
                                                color: Colors.black87,
                                              ),
                                              backgroundColor:
                                                  colors[random.nextInt(4)],
                                            ),
                                          ],
                                        ),
                                        title: Text(
                                          messageState.listMessage
                                              .elementAt(index)
                                              .address
                                              .toString(),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        subtitle: Row(
                                          children: [
                                            Flexible(
                                              child: Text(
                                                messageState.listMessage
                                                    .elementAt(index)
                                                    .body
                                                    .toString(),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
