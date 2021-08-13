import 'dart:math';
import 'package:chat_app/services/sms_service.dart';
import 'package:chat_app/utils/uiUtil/constant.dart';
import 'package:chat_app/views/message_room/message_detail.dart';
import 'package:chat_app/widgets/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

class SentMessage extends GetView<SmsService> {
  final List colors = [
    Colors.purpleAccent,
    Colors.green[300],
    Colors.deepOrangeAccent,
    Colors.grey
  ];
  Random random = new Random();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context, "Sent", false, true),
      resizeToAvoidBottomInset: false,
      body: GetBuilder<SmsService>(
        init: SmsService(),
        builder: (value) => SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.fromLTRB(0, 2, 0, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: ListView.builder(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      physics: new ClampingScrollPhysics(),
                      itemCount: value.sentMessage.length,
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
                                            smsMessage: value.sentMessage
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
                                        value.sentMessage
                                            .elementAt(index)
                                            .address
                                            .toString(),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      subtitle: Row(
                                        children: [
                                          Flexible(
                                            child: Text(
                                              value.sentMessage
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
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
