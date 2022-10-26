import 'package:flutter/material.dart';
import 'package:qr_chat_app/helpers/functions.dart';
import 'package:qr_chat_app/models/room.dart';
import 'package:qr_chat_app/providers/room.dart';
import 'package:qr_chat_app/screens/room_setting.dart';

class RoomScreen extends StatelessWidget {
  final RoomProvider roomProvider;
  final RoomModel room;

  const RoomScreen({
    required this.roomProvider,
    required this.room,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const Border(bottom: BorderSide(color: Color(0xFF333333))),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.chevron_left),
        ),
        centerTitle: true,
        title: Text(room.name),
        actions: [
          IconButton(
            onPressed: () => overlayScreen(
              context,
              RoomSettingScreen(roomProvider: roomProvider, room: room),
            ),
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: Container(),
    );
  }
}
