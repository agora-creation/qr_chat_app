import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

void pushScreen(BuildContext context, Widget widget) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => widget),
  );
}

void pushReplacementScreen(BuildContext context, Widget widget) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => widget, fullscreenDialog: true),
  );
}

void overlayScreen(BuildContext context, Widget widget) {
  showMaterialModalBottomSheet(
    context: context,
    expand: true,
    builder: (context) => widget,
  );
}

String dateText(String format, DateTime? date) {
  String ret = '';
  if (date != null) {
    ret = DateFormat(format, 'ja').format(date);
  }
  return ret;
}
