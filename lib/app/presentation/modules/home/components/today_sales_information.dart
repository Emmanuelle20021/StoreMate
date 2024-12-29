import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_mate/app/data/utils/constants/themes.dart';
import 'package:store_mate/app/domain/models/summary_data.dart';
import 'package:store_mate/app/presentation/bloc/today_profit_cubit.dart';

class TodaySalesInformation extends StatelessWidget {
  const TodaySalesInformation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodayProfitCubit, SummaryData>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            RichText(
              text: TextSpan(
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  height: 1.5,
                ),
                children: [
                  const TextSpan(
                    text: 'Ventas del día\n',
                    style: TextStyle(
                      color: kTextColor,
                      fontSize: kLargeText,
                    ),
                  ),
                  TextSpan(
                    text: '\$${state.totalAmount.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: kPrimary,
                      fontSize: kFocusTextSize,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(color: kLightTextColor),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Número de transacciones:',
                  style: TextStyle(
                    color: kTextColor,
                    fontSize: kMediumText,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  state.sales.toString(),
                  style: const TextStyle(
                    color: kPrimary,
                    fontSize: kMediumText,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Hora de la última actualización:',
                  style: TextStyle(
                    color: kTextColor,
                    fontSize: kMediumText,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  state.lastTime.format(context),
                  style: const TextStyle(
                    color: kPrimary,
                    fontSize: kMediumText,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
