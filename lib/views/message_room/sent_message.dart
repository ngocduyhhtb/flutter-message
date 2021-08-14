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

class SentMessage extends StatelessWidget {
  final List colors = [
    Colors.purpleAccent,
    Colors.green[300],
    Colors.deepOrangeAccent,
    Colors.grey
  ];
  final random = Random();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context, "Sent", false, true),
      backgroundColor: App.primaryColor,
      resizeToAvoidBottomInset: false,
      body: BlocProvider<MessageBloc>(
        create: (context) => MessageBloc()..add(LoadSentMessage()),
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
          builder: (context, state) {
            return SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.fromLTRB(0, 2, 0, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: ListView.builder(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        physics: new ClampingScrollPhysics(),
                        itemCount: state.listMessage.length,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return new Column(
                            children: <Widget>[
                              InkWell(
                                onTap: () => {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MessageDetail(
                                              smsMessage: state.listMessage
                                                  .elementAt(index),
                                              canBeReply: true)))
                                },
                                child: Card(
                                  margin: EdgeInsets.fromLTRB(4, 4, 4, 4),
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
                                            )
                                          ],
                                        ),
                                        title: Text(
                                          state.listMessage
                                              .elementAt(index)
                                              .address
                                              .toString(),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        subtitle: Row(
                                          children: [
                                            Flexible(
                                              child: Text(
                                                state.listMessage
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
            );
          },
        ),
      ),
    );
  }
}
