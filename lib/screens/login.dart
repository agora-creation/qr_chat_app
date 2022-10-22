import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:qr_chat_app/helpers/functions.dart';
import 'package:qr_chat_app/helpers/style.dart';
import 'package:qr_chat_app/providers/user.dart';
import 'package:qr_chat_app/screens/home.dart';
import 'package:qr_chat_app/widgets/custom_text_form_field.dart';
import 'package:qr_chat_app/widgets/round_lg_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                        const SizedBox(height: 16),
                        RoundLgButton(
                          labelText: '認証する',
                          labelColor: Colors.white,
                          backgroundColor: Colors.blue,
                          onPressed: () async {
                            String? errorText = await userProvider.login();
                            if (errorText != null) {
                              return;
                            }
                            userProvider.clearController();
                            if (!mounted) return;
                            pushReplacementScreen(context, const HomeScreen());
                          },
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
