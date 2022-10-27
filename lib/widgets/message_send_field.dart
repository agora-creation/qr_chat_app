import 'package:flutter/material.dart';

class MessageSendField extends StatelessWidget {
  final TextEditingController controller;
  final Function()? onPressed;

  const MessageSendField({
    required this.controller,
    this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Color(0xFF333333))),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
              child: TextField(
                controller: controller,
                decoration: const InputDecoration.collapsed(
                  hintText: 'メッセージを入力...',
                ),
                keyboardType: TextInputType.multiline,
                maxLines: null,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            child: IconButton(
              onPressed: onPressed,
              icon: const Icon(Icons.send),
            ),
          ),
        ],
      ),
    );
  }
}
