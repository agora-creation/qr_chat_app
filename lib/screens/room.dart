import 'package:flutter/material.dart';
import 'package:qr_chat_app/helpers/dialogs.dart';
import 'package:qr_chat_app/helpers/functions.dart';
import 'package:qr_chat_app/models/room.dart';
import 'package:qr_chat_app/models/user.dart';
import 'package:qr_chat_app/providers/room.dart';
import 'package:qr_chat_app/providers/room_chat.dart';
import 'package:qr_chat_app/screens/room_qr.dart';
import 'package:qr_chat_app/screens/room_setting.dart';
import 'package:qr_chat_app/widgets/custom_text_button.dart';
import 'package:qr_chat_app/widgets/custom_text_form_field.dart';

class RoomScreen extends StatefulWidget {
  final RoomProvider roomProvider;
  final RoomChatProvider roomChatProvider;
  final RoomModel room;
  final UserModel user;

  const RoomScreen({
    required this.roomProvider,
    required this.roomChatProvider,
    required this.room,
    required this.user,
    Key? key,
  }) : super(key: key);

  @override
  State<RoomScreen> createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  @override
  Widget build(BuildContext context) {
    String code = widget.room.color;
    int count = widget.room.userIds.length;

    return Scaffold(
      backgroundColor: Color(int.parse(code, radix: 16)),
      appBar: AppBar(
        shape: const Border(bottom: BorderSide(color: Color(0xFF333333))),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.chevron_left),
        ),
        centerTitle: true,
        title: Text('${widget.room.name} ($count)'),
        actions: [
          IconButton(
            onPressed: () => overlayScreen(
              context,
              RoomQRScreen(room: widget.room),
            ),
            icon: const Icon(Icons.qr_code),
          ),
          IconButton(
            onPressed: () => overlayScreen(
              context,
              RoomSettingScreen(
                roomProvider: widget.roomProvider,
                room: widget.room,
                user: widget.user,
              ),
            ),
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: CustomTextFormField(
                    controller: widget.roomChatProvider.messageController,
                    keyboardType: TextInputType.multiline,
                    labelText: '何かメッセージ',
                  ),
                ),
                CustomTextButton(
                  labelText: '送信',
                  backgroundColor: Colors.grey,
                  onPressed: () async {
                    String? errorText = await widget.roomChatProvider.create(
                      room: widget.room,
                      user: widget.user,
                    );
                    if (errorText != null) {
                      if (!mounted) return;
                      errorDialog(context, errorText);
                      return;
                    }
                    widget.roomChatProvider.clearController();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
