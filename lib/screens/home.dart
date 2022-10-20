import 'package:flutter/material.dart';
import 'package:qr_chat_app/helpers/functions.dart';
import 'package:qr_chat_app/screens/chat.dart';
import 'package:qr_chat_app/screens/room_add.dart';
import 'package:qr_chat_app/screens/user.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const Border(bottom: BorderSide(color: Color(0xFF333333))),
        automaticallyImplyLeading: false,
        title: const Text('ルーム一覧'),
        actions: [
          IconButton(
            onPressed: () => overlayScreen(context, const UserScreen()),
            icon: const Icon(Icons.person),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (_, index) {
          return Container(
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Color(0xFFCCCCCC))),
            ),
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.green,
              ),
              title: const Text('雑談部屋'),
              subtitle: const Text('明日、何時に集合？'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => pushScreen(context, const ChatScreen()),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => overlayScreen(context, const RoomAddScreen()),
        label: const Text('ルーム追加'),
        icon: const Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
