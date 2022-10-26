import 'package:flutter/material.dart';
import 'package:qr_chat_app/helpers/dialogs.dart';
import 'package:qr_chat_app/models/user.dart';
import 'package:qr_chat_app/providers/room.dart';
import 'package:qr_chat_app/widgets/custom_text_form_field.dart';
import 'package:qr_chat_app/widgets/round_lg_button.dart';

class RoomAddScreen extends StatefulWidget {
  final RoomProvider roomProvider;
  final UserModel? user;

  const RoomAddScreen({
    required this.roomProvider,
    this.user,
    Key? key,
  }) : super(key: key);

  @override
  State<RoomAddScreen> createState() => _RoomAddScreenState();
}

class _RoomAddScreenState extends State<RoomAddScreen> {
  Color colorController = const Color(0xFFFFFFFF);

  void changeColor(Color color) {
    setState(() => colorController = color);
  }

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
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        children: [
          GestureDetector(
            onTap: () => colorDialog(
              context,
              colorController,
              changeColor,
            ),
            child: CircleAvatar(
              backgroundColor: colorController,
              radius: 80,
            ),
          ),
          const SizedBox(height: 16),
          CustomTextFormField(
            controller: widget.roomProvider.nameController,
            keyboardType: TextInputType.name,
            labelText: 'ルームの名前',
            iconData: Icons.short_text,
          ),
          const SizedBox(height: 16),
          RoundLgButton(
            labelText: '上記内容で追加',
            labelColor: Colors.white,
            backgroundColor: Colors.blue,
            onPressed: () async {
              String? errorText = await widget.roomProvider.create(
                user: widget.user,
                color: colorController,
              );
              if (errorText != null) {
                if (!mounted) return;
                errorDialog(context, errorText);
                return;
              }
              widget.roomProvider.clearController();
              if (!mounted) return;
              Navigator.of(context, rootNavigator: true).pop();
            },
          ),
        ],
      ),
    );
  }
}
