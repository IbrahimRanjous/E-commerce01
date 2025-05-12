import 'package:flutter/material.dart';

/// CustomPopupDialog is a reusable dialog widget that displays a title,
/// content, and two buttons (Cancel and OK).
class CustomPopupDialog extends StatelessWidget {
  final String title;
  final String content;
  final String cancelText;
  final String okText;
  final void Function()? onPressedCancel;
  final void Function()? onPressedOK;

  /// You can override default texts if needed.
  const CustomPopupDialog({
    super.key,
    this.title = 'Comfirming',
    this.content = 'Are you sure about that ?',
    this.cancelText = 'Cancel',
    this.okText = 'Yes',
    required this.onPressedCancel,
    required this.onPressedOK,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        TextButton(
          onPressed: onPressedCancel,
          child: Text(cancelText),
        ),
        TextButton(
          onPressed: onPressedOK,
          child: Text(okText),
        ),
      ],
    );
  }
}
