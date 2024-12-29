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
          const SizedBox(height: kDefaultGap),
          Expanded(
            child: BlocBuilder<SalesCubit, List<Sale>>(
              builder: (context, salesState) {
                if (salesState.isEmpty) {
                  return const Center(
                    child: Text(
                      'No hay ventas recientes',
                      style: TextStyle(
                        color: kTextColor,
                        fontSize: kMediumText,
                      ),
                    ),
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
