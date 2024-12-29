import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_mate/app/data/utils/constants/themes.dart';
import 'package:store_mate/app/domain/models/sale.dart';
import 'package:store_mate/app/presentation/bloc/sales_cubit.dart';
import 'package:store_mate/app/presentation/global/widgets/light_primary_button.dart';
import 'package:store_mate/app/presentation/global/widgets/sale_card.dart';
import 'package:store_mate/app/presentation/routes/routes.dart';

class LastSalesWidget extends StatelessWidget {
  const LastSalesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Ventas recientes',
                style: TextStyle(
                  color: kTextColor,
                  fontSize: kLargeText,
                ),
              ),
              LightPrimaryButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    Routes.sales,
                  );
                },
                text: 'Ver más',
              ),
            ],
          ),
          Expanded(
            child: BlocBuilder<SalesCubit, List<Sale>>(
              builder: (context, salesState) {
                if (salesState.isEmpty) {
                  return Wrap(
                    runAlignment: WrapAlignment.center,
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Image.asset(
                        kWelcomeMatePath,
                        height: 150,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                text: 'Parece que no hay ventas recientes,\n',
                                style: TextStyle(
                                  color: kTextColor,
                                  fontSize: kSmallText,
                                ),
                                children: [
                                  TextSpan(
                                    text: 'que tal si creas una nueva',
                                    style: TextStyle(
                                      color: kPrimary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: kDefaultPadding,
                  ),
                  child: ListView.builder(
                    itemCount: salesState.length,
                    itemBuilder: (context, index) {
                      return SaleCard(
                        sale: salesState[index],
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            Routes.saleDetail,
                            arguments: salesState[index],
                          );
                        },
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
