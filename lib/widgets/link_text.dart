import 'package:flutter/material.dart';

class LinkText extends StatelessWidget {
  final String? labelText;
  final Function()? onTap;

  const LinkText({
    this.labelText,
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        labelText ?? '',
        style: const TextStyle(
          fontSize: 16,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
