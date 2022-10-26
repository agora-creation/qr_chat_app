import 'package:flutter/material.dart';
import 'package:qr_chat_app/helpers/dialogs.dart';
import 'package:qr_chat_app/helpers/functions.dart';
import 'package:qr_chat_app/models/room.dart';
import 'package:qr_chat_app/providers/room.dart';
import 'package:qr_chat_app/screens/home.dart';
import 'package:qr_chat_app/widgets/custom_text_form_field.dart';
import 'package:qr_chat_app/widgets/round_lg_button.dart';

class RoomSettingScreen extends StatefulWidget {
  final RoomProvider roomProvider;
  final RoomModel room;

  const RoomSettingScreen({
    required this.roomProvider,
    required this.room,
    Key? key,
  }) : super(key: key);

  @override
  State<RoomSettingScreen> createState() => _RoomSettingScreenState();
}

class _RoomSettingScreenState extends State<RoomSettingScreen> {
  Color colorController = const Color(0xFFFFFFFF);

  void changeColor(Color color) {
    setState(() => colorController = color);
  }

  @override
  void initState() {
    super.initState();
    widget.roomProvider.nameController.text = widget.room.name;
    String code = widget.room.color;
    colorController = Color(int.parse(code, radix: 16));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const Border(bottom: BorderSide(color: Color(0xFF333333))),
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text('${widget.room.name}の設定'),
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
            labelText: '変更内容を保存',
            labelColor: Colors.white,
            backgroundColor: Colors.blue,
            onPressed: () async {
              String? errorText = await widget.roomProvider.update(
                room: widget.room,
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
          const SizedBox(height: 8),
          RoundLgButton(
            labelText: 'ルームを消去',
            labelColor: Colors.red,
            borderColor: Colors.red,
            onPressed: () async {
              String? errorText = await widget.roomProvider.delete(
                room: widget.room,
              );
              if (errorText != null) {
                if (!mounted) return;
                errorDialog(context, errorText);
                return;
              }
              widget.roomProvider.clearController();
              if (!mounted) return;
              pushReplacementScreen(context, const HomeScreen());
            },
          ),
        ],
      ),
    );
  }
}
