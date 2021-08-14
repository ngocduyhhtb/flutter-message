import 'package:chat_app/services/sms_service.dart';
import 'package:chat_app/utils/uiUtil/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

// final SmsManager smsManager = GetIt.instance.get<SmsManager>();
TextEditingController smsController = new TextEditingController();

class MessageDetail extends StatelessWidget {
  MessageDetail({required this.smsMessage, required this.canBeReply});

  final dynamic smsMessage;
  final bool canBeReply;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: App.primaryColor,
      appBar: AppBar(
        backgroundColor: App.primaryColor,
        leading: ElevatedButton(
          onPressed: () => Navigator.pop(context),
          style:
              ElevatedButton.styleFrom(primary: App.primaryColor, elevation: 0),
          child: Icon(MaterialIcons.keyboard_backspace),
        ),
        title: Text(smsMessage.address.toString()),
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(10, 0, 16, 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ListTile(
                        leading: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 18,
                              child: Icon(
                                MaterialIcons.account_circle,
                                // color: Colors.black87,
                              ),
                            )
                          ],
                        ),
                        title: Text(
                          smsMessage.body.toString(),
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  canBeReply
                      ? Container(
                          // margin: EdgeInsets.fromLTRB(20, 3, 20, 3),
                          decoration: BoxDecoration(
                            color: Colors.grey[800],
                            borderRadius: BorderRadius.circular(32),
                          ),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                            child: TextField(
                              controller: smsController,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                hintText: 'Nhắn tin',
                                hintStyle: TextStyle(
                                  fontSize: 14,
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(MaterialIcons.send),
                                  onPressed: () => {print("cc")},
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        )
                      : Text("This sms can't be reply"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
