import 'package:flutter/material.dart';
import 'package:store_mate/app/data/utils/constants/themes.dart';
import 'package:store_mate/app/presentation/global/widgets/card_button.dart';
import 'package:store_mate/app/presentation/routes/routes.dart';

class HomeButtonsRow extends StatelessWidget {
  const HomeButtonsRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final Size cardSize = Size(
          (constraints.maxWidth / 3) - ((kDefaultGap / 2) * 2),
          80,
        );
        return Row(
          spacing: kDefaultGap,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CardButton(
              size: Size(
                constraints.maxWidth / 3.5,
                80,
              ),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  Routes.newSale,
                );
              },
              icon: Icons.sell,
              text: 'Nueva Venta',
              color: kPrimary,
              textColor: kContainer,
              overlayColor: kOnPrimary,
            ),
            CardButton(
              size: cardSize,
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  Routes.newProduct,
                );
              },
              icon: Icons.add,
              text: 'Nuevo Producto',
              color: kContainer,
              textColor: kPrimary,
            ),
            CardButton(
              size: cardSize,
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  Routes.products,
                );
              },
              icon: Icons.inventory_2_outlined,
              text: 'Catálogo',
              color: kContainer,
              textColor: kPrimary,
            ),
          ],
        );
      },
    );
  }
}
