import 'dart:ui';

import 'package:flutter/material.dart';

class BlurDialogWidget extends StatelessWidget {
  const BlurDialogWidget({
    super.key,
    required this.title,
    required this.content,
    required this.continueCallBack,
  });

  final String title;
  final String content;
  final VoidCallback continueCallBack;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = const TextStyle(color: Colors.black);
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: AlertDialog(
          title: Text(
            title,
            style: textStyle,
          ),
          content: Text(
            content,
            style: textStyle,
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("Continue"),
              onPressed: () {
                continueCallBack();
              },
            ),
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ));
  }
}
