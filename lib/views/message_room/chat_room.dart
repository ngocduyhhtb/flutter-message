import 'package:chat_app/views/message_room/inbox_message.dart';
import 'package:chat_app/views/message_room/sent_message.dart';
import 'package:chat_app/views/profile/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class ChatRoom extends StatefulWidget {
  const ChatRoom({Key? key}) : super(key: key);

  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  int _selectedIndex = 0;
  final controller = ScrollController();
  static List<Widget> _widgetOptions = <Widget>[
    InboxMessage(),
    SentMessage(),
    Profile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(MaterialIcons.sms),
            label: 'Inbox',
          ),
          BottomNavigationBarItem(
            icon: Icon(MaterialIcons.sms),
            label: 'Sent',
          ),
          BottomNavigationBarItem(
            icon: Icon(MaterialIcons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
    );
  }
}
