import 'package:flutter/material.dart';

class RoundLgButton extends StatelessWidget {
  final String? labelText;
  final Color? labelColor;
  final Color? backgroundColor;
  final Color? borderColor;
  final Function()? onPressed;

  const RoundLgButton({
    this.labelText,
    this.labelColor,
    this.backgroundColor,
    this.borderColor,
    this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: backgroundColor,
          side: borderColor != null
              ? BorderSide(color: borderColor ?? const Color(0xFF333333))
              : null,
          shape: const StadiumBorder(),
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        child: Text(
          labelText ?? '',
          style: TextStyle(
            color: labelColor,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: 'SourceHanSerif-Bold',
          ),
        ),
      ),
    );
  }
}
