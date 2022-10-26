import 'package:flutter/material.dart';
import 'package:qr_chat_app/helpers/functions.dart';
import 'package:qr_chat_app/models/room.dart';
import 'package:qr_chat_app/models/user.dart';
import 'package:qr_chat_app/providers/room.dart';
import 'package:qr_chat_app/screens/room_qr.dart';
import 'package:qr_chat_app/screens/room_setting.dart';

class RoomScreen extends StatelessWidget {
  final RoomProvider roomProvider;
  final RoomModel room;
  final UserModel user;

  const RoomScreen({
    required this.roomProvider,
    required this.room,
    required this.user,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String code = room.color;
    int count = room.userIds.length;

    return Scaffold(
      backgroundColor: Color(int.parse(code, radix: 16)),
      appBar: AppBar(
        shape: const Border(bottom: BorderSide(color: Color(0xFF333333))),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.chevron_left),
        ),
        centerTitle: true,
        title: Text('${room.name} ($count)'),
        actions: [
          IconButton(
            onPressed: () => overlayScreen(
              context,
              RoomQRScreen(room: room),
            ),
            icon: const Icon(Icons.qr_code),
          ),
          IconButton(
            onPressed: () => overlayScreen(
              context,
              RoomSettingScreen(
                roomProvider: roomProvider,
                room: room,
                user: user,
              ),
            ),
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: Container(),
    );
  }
}
