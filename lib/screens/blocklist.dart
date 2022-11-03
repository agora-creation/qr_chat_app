import 'package:flutter/material.dart';
import 'package:qr_chat_app/helpers/dialogs.dart';
import 'package:qr_chat_app/models/user.dart';
import 'package:qr_chat_app/providers/user.dart';

class BlockListScreen extends StatefulWidget {
  final UserProvider userProvider;
  final UserModel user;

  const BlockListScreen({
    required this.userProvider,
    required this.user,
    Key? key,
  }) : super(key: key);

  @override
  State<BlockListScreen> createState() => _BlockListScreenState();
}

class _BlockListScreenState extends State<BlockListScreen> {
  List<UserModel> users = [];
  List<UserModel> selected = [];

  void checkUser(bool value, UserModel user) {
    if (value) {
      var contain = selected.where((e) => e.id == user.id);
      if (contain.isEmpty) {
        setState(() => selected.add(user));
      }
    } else {
      setState(() => selected.removeWhere((e) => e.id == user.id));
    }
  }

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
            onPressed: () async {
              String? errorText =
                  await widget.userProvider.updateRemoveBlock(selected);
              if (errorText != null) {
                if (!mounted) return;
                errorDialog(context, errorText);
                return;
              }
              await widget.userProvider.reloadUser();
              if (!mounted) return;
              Navigator.pop(context);
            },
            child: const Text('解除'),
          ),
        ],
      ),
      body: FutureBuilder<List<UserModel>>(
        future: widget.userProvider.selectBlockList(widget.user.blockUserIds),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            users = snapshot.data ?? [];
          }
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (_, index) {
              UserModel user = users[index];
              var contain = selected.where((e) => e.id == user.id);
              return CheckboxListTile(
                title: Text(user.name),
                value: contain.isNotEmpty,
                onChanged: (value) {
                  checkUser(value ?? false, user);
                },
                controlAffinity: ListTileControlAffinity.leading,
              );
            },
          );
        },
      ),
    );
  }
}
