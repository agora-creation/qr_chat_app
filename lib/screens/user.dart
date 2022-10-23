import 'package:flutter/material.dart';
import 'package:qr_chat_app/helpers/dialogs.dart';
import 'package:qr_chat_app/helpers/functions.dart';
import 'package:qr_chat_app/models/user.dart';
import 'package:qr_chat_app/providers/user.dart';
import 'package:qr_chat_app/screens/login.dart';
import 'package:qr_chat_app/widgets/custom_text_form_field.dart';
import 'package:qr_chat_app/widgets/round_lg_button.dart';

class UserScreen extends StatefulWidget {
  final UserProvider userProvider;

  const UserScreen({
    required this.userProvider,
    Key? key,
  }) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  void initState() {
    super.initState();
    UserModel? user = widget.userProvider.user;
    widget.userProvider.emailController.text = user?.email ?? '';
    widget.userProvider.passwordController.text = user?.password ?? '';
    widget.userProvider.nameController.text = user?.name ?? '';
  }

  @override
  Widget build(BuildContext context) {
    String color = widget.userProvider.user?.color ?? 'FFFFFFFF';

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
          GestureDetector(
            onTap: () => colorDialog(context, widget.userProvider),
            child: CircleAvatar(
              backgroundColor: Color(int.parse(color, radix: 16)),
              radius: 80,
            ),
          ),
          const SizedBox(height: 16),
          CustomTextFormField(
            controller: widget.userProvider.nameController,
            keyboardType: TextInputType.name,
            labelText: 'あなたのお名前',
            iconData: Icons.short_text,
          ),
          const SizedBox(height: 8),
          CustomTextFormField(
            controller: widget.userProvider.emailController,
            keyboardType: TextInputType.emailAddress,
            labelText: 'メールアドレス',
            iconData: Icons.email,
          ),
          const SizedBox(height: 8),
          CustomTextFormField(
            controller: widget.userProvider.passwordController,
            keyboardType: TextInputType.visiblePassword,
            labelText: 'パスワード',
            iconData: Icons.lock,
          ),
          const SizedBox(height: 8),
          RoundLgButton(
            labelText: '変更内容を保存',
            labelColor: Colors.white,
            backgroundColor: Colors.blue,
            onPressed: () async {
              String? errorText = await widget.userProvider.updateInfo();
              if (errorText != null) {
                if (!mounted) return;
                errorDialog(context, errorText);
                return;
              }
              await widget.userProvider.reloadUser();
              widget.userProvider.clearController();
              if (!mounted) return;
              Navigator.of(context, rootNavigator: true).pop();
            },
          ),
          const SizedBox(height: 16),
          RoundLgButton(
            labelText: 'ログアウト',
            labelColor: Colors.red,
            borderColor: Colors.red,
            onPressed: () async {
              await widget.userProvider.logout();
              if (!mounted) return;
              pushReplacementScreen(context, const LoginScreen());
            },
          ),
        ],
      ),
    );
  }
}
