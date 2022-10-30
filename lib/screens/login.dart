import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:qr_chat_app/helpers/dialogs.dart';
import 'package:qr_chat_app/helpers/functions.dart';
import 'package:qr_chat_app/helpers/style.dart';
import 'package:qr_chat_app/providers/user.dart';
import 'package:qr_chat_app/screens/home.dart';
import 'package:qr_chat_app/screens/regist.dart';
import 'package:qr_chat_app/widgets/custom_text_form_field.dart';
import 'package:qr_chat_app/widgets/link_text.dart';
import 'package:qr_chat_app/widgets/round_lg_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isAgree = false;

  void changeAgree(bool value) {
    setState(() => isAgree = value);
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SizedBox(
            height: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text('QR-CHAT', style: kTitleStyle),
                    Column(
                      children: [
                        CustomTextFormField(
                          controller: userProvider.emailController,
                          keyboardType: TextInputType.emailAddress,
                          labelText: 'メールアドレス',
                          iconData: Icons.email,
                        ),
                        const SizedBox(height: 8),
                        CustomTextFormField(
                          controller: userProvider.passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          labelText: 'パスワード',
                          iconData: Icons.lock,
                        ),
                        const SizedBox(height: 16),
                        CheckboxListTile(
                          value: isAgree,
                          title: const Text('利用規約に同意する'),
                          controlAffinity: ListTileControlAffinity.leading,
                          onChanged: (value) {
                            agreeDialog(context, changeAgree);
                          },
                        ),
                        isAgree
                            ? RoundLgButton(
                                labelText: 'ログイン',
                                labelColor: Colors.white,
                                backgroundColor: Colors.blue,
                                onPressed: () async {
                                  String? errorText =
                                      await userProvider.login();
                                  if (errorText != null) {
                                    if (!mounted) return;
                                    errorDialog(context, errorText);
                                    return;
                                  }
                                  userProvider.clearController();
                                  if (!mounted) return;
                                  pushReplacementScreen(
                                      context, const HomeScreen());
                                },
                              )
                            : const RoundLgButton(
                                labelText: 'ログイン',
                                labelColor: Colors.white,
                                backgroundColor: Colors.grey,
                              ),
                        const SizedBox(height: 16),
                        LinkText(
                          onTap: () => pushScreen(
                            context,
                            const RegistScreen(),
                          ),
                          labelText: '初めての方はコチラから',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
