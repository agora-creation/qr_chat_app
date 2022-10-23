import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:qr_chat_app/providers/user.dart';
import 'package:qr_chat_app/widgets/custom_text_button.dart';

void errorDialog(BuildContext context, String msg) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          const Center(
            child: Icon(
              Icons.error,
              color: Colors.red,
              size: 32,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            msg,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextButton(
                labelText: '戻る',
                backgroundColor: Colors.grey,
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

void colorDialog(BuildContext context, UserProvider userProvider) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (_) => ColorAlertDialog(userProvider: userProvider),
  ).then((value) async {
    await userProvider.reloadUser();
  });
}

class ColorAlertDialog extends StatefulWidget {
  final UserProvider userProvider;

  const ColorAlertDialog({
    required this.userProvider,
    Key? key,
  }) : super(key: key);

  @override
  State<ColorAlertDialog> createState() => _ColorAlertDialogState();
}

class _ColorAlertDialogState extends State<ColorAlertDialog> {
  Color pickerColor = const Color(0xFFFFFFFF);

  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  @override
  void initState() {
    super.initState();
    String color = widget.userProvider.user?.color ?? 'FFFFFFFF';
    pickerColor = Color(int.parse(color, radix: 16));
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('あなたの色を設定'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ColorPicker(
            pickerColor: pickerColor,
            onColorChanged: changeColor,
            enableAlpha: false,
            showLabel: false,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomTextButton(
                labelText: 'キャンセル',
                backgroundColor: Colors.grey,
                onPressed: () => Navigator.pop(context),
              ),
              CustomTextButton(
                labelText: '反映する',
                backgroundColor: Colors.blue,
                onPressed: () async {
                  String? errorText = await widget.userProvider.updateColor(
                    pickerColor,
                  );
                  if (errorText != null) {
                    if (!mounted) return;
                    errorDialog(context, errorText);
                    return;
                  }

                  if (!mounted) return;
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
