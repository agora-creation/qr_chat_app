import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final String value;

  const CustomListTile({
    required this.title,
    required this.value,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFFCCCCCC))),
      ),
      child: ListTile(
        title: Text(title),
        trailing: Text(value),
      ),
    );
  }
}
