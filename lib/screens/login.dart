import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_chat_app/helpers/functions.dart';
import 'package:qr_chat_app/screens/home.dart';
import 'package:qr_chat_app/widgets/custom_text_form_field.dart';
import 'package:qr_chat_app/widgets/round_lg_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                    const Text(
                      'QR-CHAT',
                      style: TextStyle(
                        color: Color(0xFF333333),
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'SourceHanSerif-Bold',
                        letterSpacing: 1,
                      ),
                    ),
                    Column(
                      children: [
                        CustomTextFormField(
                          controller: TextEditingController(),
                          keyboardType: TextInputType.emailAddress,
                          labelText: 'メールアドレス',
                          iconData: Icons.email,
                        ),
                        const SizedBox(height: 16),
                        RoundLgButton(
                          labelText: '認証する',
                          labelColor: Colors.white,
                          backgroundColor: Colors.blue,
                          onPressed: () {
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
