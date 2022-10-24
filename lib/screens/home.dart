import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';
import 'package:qr_chat_app/helpers/functions.dart';
import 'package:qr_chat_app/providers/user.dart';
import 'package:qr_chat_app/screens/chat.dart';
import 'package:qr_chat_app/screens/room_add.dart';
import 'package:qr_chat_app/screens/user.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

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
      body: ListView.builder(
        itemCount: 5,
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
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: const IconThemeData(size: 22),
        curve: Curves.bounceIn,
        children: [
          SpeedDialChild(
            child: const Icon(Icons.create, color: Colors.white),
            backgroundColor: Colors.blue,
            label: 'ルームを作成',
            labelStyle: const TextStyle(fontWeight: FontWeight.bold),
            onTap: () => overlayScreen(context, const RoomAddScreen()),
          ),
          SpeedDialChild(
            child: const Icon(Icons.qr_code, color: Colors.white),
            backgroundColor: Colors.green,
            label: 'ルームに参加',
            onTap: () => overlayScreen(context, const RoomAddScreen()),
          ),
        ],
      ),
    );
  }
}
