import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:qr_chat_app/widgets/custom_text_form_field.dart';
import 'package:qr_chat_app/widgets/round_lg_button.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  Color pickerColor = const Color(0xff443a49);
  Color currentColor = const Color(0xff443a49);

  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const Border(bottom: BorderSide(color: Color(0xFF333333))),
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text('アカウント設定'),
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
          const CircleAvatar(
            backgroundColor: Colors.grey,
            radius: 50,
          ),
          ColorPicker(
            pickerColor: pickerColor,
            onColorChanged: changeColor,
            enableAlpha: false,
            showLabel: false,
          ),
          const SizedBox(height: 16),
          CustomTextFormField(
            controller: TextEditingController(),
            keyboardType: TextInputType.name,
            labelText: 'お名前',
            iconData: Icons.short_text,
          ),
          const SizedBox(height: 16),
          CustomTextFormField(
            controller: TextEditingController(),
            keyboardType: TextInputType.emailAddress,
            labelText: 'メールアドレス',
            iconData: Icons.email,
          ),
          const SizedBox(height: 16),
          RoundLgButton(
            labelText: '変更内容を保存',
            labelColor: Colors.white,
            backgroundColor: Colors.blue,
            onPressed: () {},
          ),
          const SizedBox(height: 16),
          RoundLgButton(
            labelText: 'ログアウト',
            labelColor: Colors.red,
            borderColor: Colors.red,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
