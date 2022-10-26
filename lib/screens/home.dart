import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_chat_app/helpers/functions.dart';
import 'package:qr_chat_app/models/room.dart';
import 'package:qr_chat_app/models/user.dart';
import 'package:qr_chat_app/providers/room.dart';
import 'package:qr_chat_app/providers/user.dart';
import 'package:qr_chat_app/screens/room.dart';
import 'package:qr_chat_app/screens/room_create.dart';
import 'package:qr_chat_app/screens/user.dart';
import 'package:qr_chat_app/widgets/custom_text_button.dart';
import 'package:qr_chat_app/widgets/room_add_list.dart';
import 'package:qr_chat_app/widgets/room_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final roomProvider = Provider.of<RoomProvider>(context);
    List<RoomModel> rooms = [];

    return Scaffold(
      appBar: AppBar(
        shape: const Border(bottom: BorderSide(color: Color(0xFF333333))),
        automaticallyImplyLeading: false,
        title: const Text('ルーム一覧'),
        actions: [
          IconButton(
            onPressed: () => overlayScreen(
              context,
              UserScreen(userProvider: userProvider),
            ),
            icon: const Icon(Icons.account_circle),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: roomProvider.streamList(user: userProvider.user),
        builder: (context, snapshot) {
          rooms.clear();
          if (snapshot.hasData) {
            for (DocumentSnapshot<Map<String, dynamic>> doc
                in snapshot.data!.docs) {
              rooms.add(RoomModel.fromSnapshot(doc));
            }
          }
          if (rooms.isEmpty) {
            return const Center(
              child: Text('右下の「ルーム追加」をタップしてください。'),
            );
          }
          return ListView.builder(
            itemCount: rooms.length,
            itemBuilder: (_, index) {
              RoomModel room = rooms[index];
              return RoomList(
                room: room,
                onTap: () => pushScreen(
                  context,
                  RoomScreen(roomProvider: roomProvider, room: room),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => RoomAddDialog(
              roomProvider: roomProvider,
              user: userProvider.user,
            ),
          );
        },
        label: const Text('ルーム追加'),
        icon: const Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}

class RoomAddDialog extends StatelessWidget {
  final RoomProvider roomProvider;
  final UserModel? user;

  const RoomAddDialog({
    required this.roomProvider,
    this.user,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RoomAddList(
            iconData: Icons.create,
            labelText: 'ルームを作成',
            onTap: () => pushScreen(
              context,
              RoomCreateScreen(roomProvider: roomProvider, user: user),
            ),
          ),
          RoomAddList(
            iconData: Icons.qr_code,
            labelText: 'ルームに参加',
            onTap: () {},
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextButton(
                labelText: 'キャンセル',
                backgroundColor: Colors.grey,
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
