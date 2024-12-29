import 'package:flutter/material.dart';
import 'package:store_mate/app/data/utils/constants/themes.dart';

class WelcomeMessage extends StatelessWidget {
  const WelcomeMessage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: RichText(
        softWrap: true,
        text: const TextSpan(
          style: TextStyle(
            fontSize: kExtraLargeText,
            fontWeight: FontWeight.bold,
          ),
          children: [
            TextSpan(
              text: '¡Bienvenido de nuevo! \n',
              style: TextStyle(
                color: kOnPrimary,
                fontSize: kFocusTextSize,
              ),
            ),
            TextSpan(
              text: 'Continuemos con las ventas.',
              style: TextStyle(color: kSecondary),
            ),
          ],
        ),
      ),
    );
  }
}
