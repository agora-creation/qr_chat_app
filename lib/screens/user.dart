import 'package:flutter/material.dart';
import 'package:qr_chat_app/widgets/custom_text_form_field.dart';
import 'package:qr_chat_app/widgets/round_lg_button.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({Key? key}) : super(key: key);

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
