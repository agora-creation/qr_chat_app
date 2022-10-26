import 'package:flutter/material.dart';
import 'package:qr_chat_app/helpers/dialogs.dart';
import 'package:qr_chat_app/helpers/functions.dart';
import 'package:qr_chat_app/models/room.dart';
import 'package:qr_chat_app/models/user.dart';
import 'package:qr_chat_app/providers/room.dart';
import 'package:qr_chat_app/screens/home.dart';
import 'package:qr_chat_app/widgets/room_camera_list.dart';
import 'package:qr_chat_app/widgets/round_lg_button.dart';

class RoomCamera2Screen extends StatefulWidget {
  final RoomProvider roomProvider;
  final RoomModel room;
  final UserModel user;

  const RoomCamera2Screen({
    required this.roomProvider,
    required this.room,
    required this.user,
    Key? key,
  }) : super(key: key);

  @override
  State<RoomCamera2Screen> createState() => _RoomCamera2ScreenState();
}

class _RoomCamera2ScreenState extends State<RoomCamera2Screen> {
  @override
  Widget build(BuildContext context) {
    var contain = widget.room.userIds.where((e) => e == widget.user.id);

    return Scaffold(
      appBar: AppBar(
        shape: const Border(bottom: BorderSide(color: Color(0xFF333333))),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.chevron_left),
        ),
        centerTitle: true,
        title: const Text('QRコード読取結果'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        children: [
          RoomCameraList(room: widget.room),
          const SizedBox(height: 16),
          contain.isEmpty
              ? RoundLgButton(
                  labelText: 'このルームに参加する',
                  labelColor: Colors.white,
                  backgroundColor: Colors.blue,
                  onPressed: () async {
                    String? errorText = await widget.roomProvider.updateIn(
                      room: widget.room,
                      user: widget.user,
                    );
                    if (errorText != null) {
                      if (!mounted) return;
                      errorDialog(context, errorText);
                      return;
                    }
                    if (!mounted) return;
                    pushReplacementScreen(context, const HomeScreen());
                  },
                )
              : RoundLgButton(
                  labelText: '既に参加済',
                  labelColor: Colors.white,
                  backgroundColor: Colors.grey,
                  onPressed: () {},
                ),
        ],
      ),
    );
  }
}
