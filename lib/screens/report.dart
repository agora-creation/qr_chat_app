import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_chat_app/helpers/dialogs.dart';
import 'package:qr_chat_app/models/room_chat.dart';
import 'package:qr_chat_app/providers/report.dart';
import 'package:qr_chat_app/widgets/custom_list_tile.dart';
import 'package:qr_chat_app/widgets/round_lg_button.dart';

class ReportScreen extends StatefulWidget {
  final RoomChatModel chat;

  const ReportScreen({required this.chat, Key? key}) : super(key: key);

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  @override
  Widget build(BuildContext context) {
    final reportProvider = Provider.of<ReportProvider>(context);

    return Scaffold(
      appBar: AppBar(
        shape: const Border(bottom: BorderSide(color: Color(0xFF333333))),
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text('メッセージの違反報告'),
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
          CustomListTile(title: 'アカウント', value: widget.chat.userName),
          CustomListTile(title: 'メッセージ', value: widget.chat.message),
          const SizedBox(height: 16),
          RoundLgButton(
            labelText: 'このメッセージを違反報告する',
            labelColor: Colors.white,
            backgroundColor: Colors.red,
            onPressed: () async {
              String? errorText = await reportProvider.create(widget.chat);
              if (errorText != null) {
                if (!mounted) return;
                errorDialog(context, errorText);
                return;
              }
              if (!mounted) return;
              Navigator.of(context, rootNavigator: true).pop();
            },
          ),
        ],
      ),
    );
  }
}
