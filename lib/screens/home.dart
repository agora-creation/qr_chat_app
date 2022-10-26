import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_chat_app/helpers/functions.dart';
import 'package:qr_chat_app/models/room.dart';
import 'package:qr_chat_app/providers/room.dart';
import 'package:qr_chat_app/providers/user.dart';
import 'package:qr_chat_app/screens/room.dart';
import 'package:qr_chat_app/screens/room_add.dart';
import 'package:qr_chat_app/screens/user.dart';

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
        stream: roomProvider.streamList(),
        builder: (context, snapshot) {
          rooms.clear();
          if (snapshot.hasData) {
            for (DocumentSnapshot<Map<String, dynamic>> doc
                in snapshot.data!.docs) {
              rooms.add(RoomModel.fromSnapshot(doc));
            }
          }
          return ListView.builder(
            itemCount: rooms.length,
            itemBuilder: (_, index) {
              RoomModel room = rooms[index];
              String code = room.color;
              return Container(
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: Color(0xFFCCCCCC))),
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Color(int.parse(code, radix: 16)),
                  ),
                  title: Text(room.name),
                  subtitle: const Text('明日、何時に集合？'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => pushScreen(
                    context,
                    RoomScreen(roomProvider: roomProvider, room: room),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => overlayScreen(
          context,
          RoomAddScreen(
            roomProvider: roomProvider,
            user: userProvider.user,
          ),
        ),
        label: const Text('ルーム追加'),
        icon: const Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
