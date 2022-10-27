import 'package:flutter/material.dart';
import 'package:qr_chat_app/models/room.dart';

class RoomList extends StatelessWidget {
  final RoomModel room;
  final Function()? onTap;

  const RoomList({
    required this.room,
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String code = room.color;
    int count = room.userIds.length;

    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFCCCCCC))),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Color(int.parse(code, radix: 16)),
        ),
        title: Text('${room.name} ($count)'),
        subtitle: room.lastMessage != ''
            ? Text(
                room.lastMessage,
                style: const TextStyle(overflow: TextOverflow.ellipsis),
              )
            : null,
        onTap: onTap,
      ),
    );
  }
}
