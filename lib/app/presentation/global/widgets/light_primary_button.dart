import 'package:flutter/material.dart';

import '../../../data/utils/constants/themes.dart';

class LightPrimaryButton extends StatelessWidget {
  const LightPrimaryButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  final Function() onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        alignment: Alignment.center,
        backgroundColor: MaterialStateProperty.all(
          kPrimarylight,
        ),
        shadowColor: const MaterialStatePropertyAll(
          kNoColor,
        ),
      ),
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
