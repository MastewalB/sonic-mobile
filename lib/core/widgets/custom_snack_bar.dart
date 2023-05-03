import 'package:flutter/material.dart';

class CustomSnackBar extends SnackBar {
  final Color? color;
  final String text;
  final int? durationSeconds;
  final String? actionMessage;
  final VoidCallback? actionButton;

  CustomSnackBar({
    Key? key,
    required this.text,
    this.color,
    this.durationSeconds,
    this.actionButton,
    this.actionMessage,
  }) : super(key: key, content: Text(text));

  Widget build(BuildContext context) {
    return SnackBar(
      content: Text(text),
      duration:
          Duration(seconds: (durationSeconds != null) ? durationSeconds! : 5),
      behavior: SnackBarBehavior.floating,
      backgroundColor: (color != null) ? color! : Colors.purple.shade100,
      action: (action != null)
          ? SnackBarAction(
              label: actionMessage!,
              onPressed: actionButton!,
            )
          : null,
    );
  }
}
