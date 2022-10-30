import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qr_chat_app/helpers/dialogs.dart';
import 'package:qr_chat_app/helpers/functions.dart';
import 'package:qr_chat_app/models/room.dart';
import 'package:qr_chat_app/models/room_chat.dart';
import 'package:qr_chat_app/models/user.dart';
import 'package:qr_chat_app/providers/room.dart';
import 'package:qr_chat_app/providers/room_chat.dart';
import 'package:qr_chat_app/screens/report.dart';
import 'package:qr_chat_app/screens/room_qr.dart';
import 'package:qr_chat_app/screens/room_setting.dart';
import 'package:qr_chat_app/widgets/message_send_field.dart';

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
    List<RoomChatModel> chats = [];
    final focusNode = FocusNode();

    return Focus(
      focusNode: focusNode,
      child: GestureDetector(
        onTap: focusNode.requestFocus,
        child: Scaffold(
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
                Expanded(
                  child: Container(
                    color: Color(int.parse(code, radix: 16)),
                    child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      stream: widget.roomChatProvider.streamList(
                        room: widget.room,
                      ),
                      builder: (context, snapshot) {
                        chats.clear();
                        if (snapshot.hasData) {
                          for (DocumentSnapshot<Map<String, dynamic>> doc
                              in snapshot.data!.docs) {
                            chats.add(RoomChatModel.fromSnapshot(doc));
                          }
                        }
                        return ListView.builder(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 16,
                          ),
                          reverse: true,
                          itemCount: chats.length,
                          itemBuilder: (_, index) {
                            RoomChatModel chat = chats[index];
                            return MessageBalloon(
                              chat: chat,
                              isMe: widget.user.id == chat.userId,
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
                MessageSendField(
                  controller: widget.roomChatProvider.messageController,
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
                    focusNode.unfocus();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MessageBalloon extends StatelessWidget {
  final RoomChatModel chat;
  final bool isMe;

  const MessageBalloon({
    required this.chat,
    required this.isMe,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isMe) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Material(
              elevation: 5,
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Text(chat.message),
              ),
            ),
            Text(
              dateText('MM/dd HH:mm', chat.createdAt),
              style: const TextStyle(fontSize: 12, color: Colors.black54),
            ),
          ],
        ),
      );
    } else {
      String code = chat.userColor;
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              chat.userName,
              style: const TextStyle(fontSize: 12, color: Colors.black54),
            ),
            const SizedBox(height: 4),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: Color(int.parse(code, radix: 16)),
                  radius: 16,
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onLongPressUp: () => overlayScreen(
                        context,
                        ReportScreen(chat: chat),
                      ),
                      child: Material(
                        elevation: 4,
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.blue.shade200,
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(chat.message),
                        ),
                      ),
                    ),
                    Text(
                      dateText('MM/dd HH:mm', chat.createdAt),
                      style:
                          const TextStyle(fontSize: 12, color: Colors.black54),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      );
    }
  }
}
