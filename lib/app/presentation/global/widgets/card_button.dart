import 'package:flutter/material.dart';

import '../../../data/utils/constants/themes.dart';

class CardButton extends StatelessWidget {
  const CardButton({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.text,
    required this.color,
    required this.textColor,
    this.overlayColor,
    this.size,
  });

  final Function() onPressed;
  final IconData icon;
  final String text;
  final Color color;
  final Color textColor;
  final Color? overlayColor;
  final Size? size;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(kMinimunPaddingSize),
        backgroundColor: color,
        fixedSize: size,
        foregroundColor: overlayColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            kDefaultButtonRadius,
          ),
        ),
      ),
      onPressed: onPressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, color: textColor),
          Text(
            text,
            style: TextStyle(
              color: textColor,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
