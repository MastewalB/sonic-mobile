import 'package:flutter/material.dart';

class CustomErrorWidget extends StatelessWidget {
  final String text;
  final String buttonText;
  final VoidCallback callback;

  const CustomErrorWidget({
    Key? key,
    required this.text,
    required this.buttonText,
    required this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          children: [
            Text(text),
            OutlinedButton(
              onPressed: callback,
              child: Text(buttonText),
            ),
          ],
        ),
      ),
    );
  }
}
