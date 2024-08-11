import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:store_mate/app/presentation/bloc/products_cubit.dart';
import 'package:store_mate/app/presentation/bloc/sale_detail_cubit.dart';
import 'package:store_mate/app/presentation/bloc/sales_cubit.dart';

import 'today_profit_cubit.dart';

class BlocsProvider extends StatelessWidget {
  const BlocsProvider({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProductsCubit(),
        ),
        BlocProvider(
          create: (context) => TodayProfitCubit(),
        ),
        BlocProvider(
          create: (context) => SalesCubit(),
        ),
        BlocProvider(
          create: (context) => SaleDetailCubit(),
        ),
      ],
      child: child,
    );
  }
}
