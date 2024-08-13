import 'package:flutter/material.dart';

import '../../../data/utils/constants/themes.dart';

class DrawerOptionButton extends StatelessWidget {
  const DrawerOptionButton({
    super.key,
    required this.icon,
    required this.text,
    required this.onPressed,
  });

  final IconData icon;
  final String text;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kDefaultButtonRadius),
          ),
        ),
        elevation: const MaterialStatePropertyAll(kNone),
        overlayColor: MaterialStatePropertyAll(
          kOnPrimary.withOpacity(kDefaultOverlayOpacity),
        ),
      ),
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: kDefaultPadding,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: kOnPrimary,
            ),
            const SizedBox(
              width: kDefaultGap,
            ),
            Text(
              text,
              style: const TextStyle(
                color: kOnPrimary,
                fontSize: kMediumText,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
