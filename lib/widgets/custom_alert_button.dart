// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomAlertButton extends StatelessWidget {
  final String titleText;
  final String contentText;
  final VoidCallback onPressed;
  final List<Widget>? actions;
  const CustomAlertButton({
    super.key,
    required this.titleText,
    required this.onPressed,
    required this.contentText,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        content: Text(contentText),
        actions: [
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("No"),
          ),
          FilledButton(
            onPressed: () {
              onPressed.call();
              Navigator.pop(context);
            },
            child: const Text("YES"),
          ),
        ],
        title: Text(titleText));
  }
}
