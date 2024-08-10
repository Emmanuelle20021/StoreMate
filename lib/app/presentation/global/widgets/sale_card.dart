import 'package:flutter/material.dart';

import '../../../data/utils/constants/themes.dart';
import 'light_primary_button.dart';

class SaleCard extends StatelessWidget {
  const SaleCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: kMinimunPaddingSize,
      ),
      child: Container(
        padding: const EdgeInsets.all(
          kDefaultPadding,
        ),
        constraints: const BoxConstraints(
          minWidth: double.infinity,
        ),
        decoration: BoxDecoration(
          color: kBackground,
          boxShadow: const [
            BoxShadow(
              blurRadius: 1,
              blurStyle: BlurStyle.outer,
              offset: Offset(0, 2),
              color: kLightTextColor,
            ),
          ],
          borderRadius: BorderRadius.circular(
            kDefaultButtonRadius,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Venta \$fecha',
              style: TextStyle(
                color: kPrimary,
                fontSize: kMediumText,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$450.00',
                  style: TextStyle(
                    color: kTextColor,
                    fontSize: kSmallText,
                  ),
                ),
                Text(
                  '5 Unidades',
                  style: TextStyle(
                    color: kTextColor,
                    fontSize: kSmallText,
                  ),
                ),
              ],
            ),
            LightPrimaryButton(
              onPressed: () {},
              text: 'Ver detalle',
            )
          ],
        ),
      ),
    );
  }
}
