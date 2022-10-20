import 'package:flutter/material.dart';

class RoomAddScreen extends StatelessWidget {
  const RoomAddScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const Border(bottom: BorderSide(color: Color(0xFF333333))),
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text('ルーム追加'),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
            icon: const Icon(Icons.close),
          ),
        ],
      ),
    );
  }
}
