import 'package:flutter/material.dart';

import '../../../data/utils/constants/themes.dart';
import '../../../domain/models/sale.dart';
import 'light_primary_button.dart';

class SaleCard extends StatelessWidget {
  const SaleCard({
    super.key,
    required this.sale,
  });
  final Sale sale;

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.parse(sale.date);
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
              offset: Offset(0, 1),
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
            Text(
              'Venta ${date.day}-${date.month}-${date.year} ${date.hour}:${date.minute}',
              style: const TextStyle(
                color: kPrimary,
                fontSize: kMediumText,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: kDefaultPadding,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  'Total: ',
                  style: TextStyle(
                    color: kTextColor,
                    fontSize: kLargeText,
                  ),
                ),
                Text(
                  '\$${sale.totalAmount}',
                  style: const TextStyle(
                    color: kTextColor,
                    fontSize: kLargeText,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: kDefaultGap,
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
