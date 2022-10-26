import 'package:flutter/material.dart';

class RoomAddList extends StatelessWidget {
  final IconData iconData;
  final String labelText;
  final Function()? onTap;

  const RoomAddList({
    required this.iconData,
    required this.labelText,
    this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFCCCCCC))),
      ),
      child: ListTile(
        leading: Icon(iconData),
        title: Text(labelText),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
