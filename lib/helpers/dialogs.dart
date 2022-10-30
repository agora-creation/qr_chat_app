import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_chat_app/widgets/custom_text_button.dart';
import 'package:webview_flutter/webview_flutter.dart';

void agreeDialog(BuildContext context, Function(bool) changeAgree) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text('利用規約'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('以下の利用規約に同意してください。'),
          Container(
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: Color(0xFF333333)),
                bottom: BorderSide(color: Color(0xFF333333)),
              ),
            ),
            height: 250,
            child: Scrollbar(
              controller: ScrollController(),
              child: const WebView(
                initialUrl: 'https://agora-c.com/qr_chat/terms_use.html',
                javascriptMode: JavascriptMode.unrestricted,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomTextButton(
                labelText: '同意しない',
                backgroundColor: Colors.grey,
                onPressed: () {
                  changeAgree(false);
                  Navigator.pop(context);
                },
              ),
              CustomTextButton(
                labelText: '同意する',
                backgroundColor: Colors.blue,
                onPressed: () {
                  changeAgree(true);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

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
          Text(msg, style: const TextStyle(fontSize: 16)),
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

void colorDialog(
  BuildContext context,
  Color colorController,
  Function(Color color) changeColor,
) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (_) => ColorAlertDialog(
      colorController: colorController,
      changeColor: changeColor,
    ),
  );
}

class ColorAlertDialog extends StatefulWidget {
  final Color colorController;
  final Function(Color color) changeColor;

  const ColorAlertDialog({
    required this.colorController,
    required this.changeColor,
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
    pickerColor = widget.colorController;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('色を設定'),
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
                labelText: '決定',
                backgroundColor: Colors.blue,
                onPressed: () {
                  widget.changeColor(pickerColor);
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

void permissionDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text('カメラ機能を許可'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('QRコードを読み取る為にカメラを利用します'),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomTextButton(
                labelText: '閉じる',
                backgroundColor: Colors.grey,
                onPressed: () => Navigator.pop(context),
              ),
              CustomTextButton(
                labelText: 'OK',
                backgroundColor: Colors.blue,
                onPressed: () => openAppSettings(),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
