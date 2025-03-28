import 'package:flutter/material.dart';

class TSectionHeading extends StatelessWidget {
  const TSectionHeading({
    super.key,
    this.buttonText = 'View all',
    this.showActionButton = false,
    this.textColor,
    this.buttonColor = Colors.black,
    required this.text,
    this.onPressed,
    this.buttonBackgroundColor,
  });
  final Color? textColor;
  final Color? buttonColor;
  final Color? buttonBackgroundColor;
  final bool changeButtonBackgroundColor = false;
  final bool showActionButton;
  final String text, buttonText;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .apply(color: textColor),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        if (showActionButton)
          TextButton(
              onPressed: onPressed,
              child: Text(
                buttonText,
                style: TextStyle(
                    color: buttonColor,
                    backgroundColor: changeButtonBackgroundColor
                        ? buttonBackgroundColor
                        : Colors.transparent),
              ))
      ],
    );
  }
}
