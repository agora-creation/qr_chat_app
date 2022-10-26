import 'package:flutter/material.dart';
import 'package:qr_chat_app/models/room.dart';

class RoomCameraList extends StatelessWidget {
  final RoomModel room;

  const RoomCameraList({required this.room, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFCCCCCC))),
      ),
      child: ListTile(
        title: const Text('ルーム名'),
        trailing: Text(room.name),
      ),
    );
  }
}
