import 'package:flutter/material.dart';
import 'package:qr_chat_app/helpers/dialogs.dart';
import 'package:qr_chat_app/models/user.dart';
import 'package:qr_chat_app/providers/room.dart';
import 'package:qr_chat_app/widgets/custom_text_form_field.dart';
import 'package:qr_chat_app/widgets/round_lg_button.dart';

class RoomCreateScreen extends StatefulWidget {
  final RoomProvider roomProvider;
  final UserModel? user;

  const RoomCreateScreen({
    required this.roomProvider,
    this.user,
    Key? key,
  }) : super(key: key);

  @override
  State<RoomCreateScreen> createState() => _RoomCreateScreenState();
}

class _RoomCreateScreenState extends State<RoomCreateScreen> {
  Color colorController = const Color(0xFFFFFFFF);

  void changeColor(Color color) {
    setState(() => colorController = color);
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
        title: const Text('ルームを作成'),
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
            labelText: '作成する',
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
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
