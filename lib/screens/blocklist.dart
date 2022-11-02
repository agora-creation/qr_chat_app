import 'package:flutter/material.dart';
import 'package:qr_chat_app/providers/user.dart';

class BlockListScreen extends StatelessWidget {
  final UserProvider userProvider;

  const BlockListScreen({
    required this.userProvider,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const Border(bottom: BorderSide(color: Color(0xFF333333))),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.chevron_left),
        ),
        centerTitle: true,
        title: const Text('ブロックリスト'),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text('解除'),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: userProvider.user?.blockUserIds.length,
        itemBuilder: (_, index) {
          return CheckboxListTile(
            title: const Text('aa'),
            value: false,
            onChanged: (value) {},
            controlAffinity: ListTileControlAffinity.leading,
          );
        },
      ),
    );
  }
}
