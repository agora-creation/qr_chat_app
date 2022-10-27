import 'package:flutter/material.dart';
import 'package:qr_chat_app/models/room.dart';
import 'package:qr_chat_app/widgets/round_lg_button.dart';
import 'package:qr_flutter/qr_flutter.dart';

class RoomQRScreen extends StatelessWidget {
  final RoomModel room;

  const RoomQRScreen({
    required this.room,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const Border(bottom: BorderSide(color: Color(0xFF333333))),
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text('ルームのQRコード'),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
            icon: const Icon(Icons.close),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        children: [
          Center(
            child: QrImage(
              data: room.id,
              version: QrVersions.auto,
              size: 200,
            ),
          ),
          const SizedBox(height: 16),
          RoundLgButton(
            labelText: '閉じる',
            labelColor: Colors.white,
            backgroundColor: Colors.grey,
            onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
          ),
        ],
      ),
    );
  }
}
