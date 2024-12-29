import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:store_mate/app/data/utils/constants/themes.dart';
import 'package:store_mate/app/domain/models/summary_data.dart';
import 'package:store_mate/app/domain/repositories/sale_repository.dart';
import 'package:store_mate/app/presentation/bloc/last_sales_cubit.dart';
import 'package:store_mate/app/presentation/bloc/today_profit_cubit.dart';
import 'package:store_mate/app/presentation/bloc/sales_cubit.dart';
import 'package:store_mate/app/presentation/modules/home/components/home_buttons_row.dart';
import 'package:store_mate/app/presentation/modules/home/components/last_sales_information.dart';
import 'package:store_mate/app/presentation/modules/home/components/today_sales_information.dart';
import 'package:store_mate/app/presentation/modules/home/components/welcome_message.dart';

import '../../../../data/utils/constants/constants.dart';
import '../../../../data/utils/injector.dart';
import '../../../../domain/models/product.dart';
import '../../../../domain/models/sale.dart';
import '../../../../domain/repositories/product_repository.dart';
import '../../../bloc/products_cubit.dart';
import '../components/custom_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initData();
    });
    FlutterNativeSplash.remove();
  }

  Future<void> _initData() async {
    try {
      SaleRepository saleRepository = Injector.of(context).saleRepository;
      ProductRepository productRepository =
          Injector.of(context).productRepository;
      SummaryData? todayProfit = await saleRepository.todaySales();
      String today = DateTime.now().toString().substring(0, 10);
      List<Sale>? sales = await saleRepository.getSales();
      List<Sale>? lastSales = await saleRepository.getSales(
        where: 'sale_creation_date LIKE ?',
        whereArgs: ['%$today%'],
        limit: 3,
        orderBy: 'sale_creation_date DESC',
      );
      List<Product>? responseProducts = await productRepository.getProducts();
      if (mounted) {
        context.read<TodayProfitCubit>().changeProfit(todayProfit);
        if (responseProducts != null) {
          context.read<ProductsCubit>().changeProducts(responseProducts);
        }
        if (sales != null) {
          context.read<SalesCubit>().changeSales(sales);
        }
        if (lastSales != null) {
          context.read<LastSalesCubit>().changeLastSales(lastSales);
        }
      }
    } catch (e) {
      //
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: kNoColor,
      ),
      drawerEnableOpenDragGesture: true,
      drawer: const CustomDrawer(),
      backgroundColor: kPrimary,
      body: Stack(
        children: [
          ...kCircleDecorations,
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: kDefaultGap,
              children: [
                WelcomeMessage(),
                Expanded(
                  child: Container(
                    constraints: const BoxConstraints(
                      minHeight: double.infinity,
                      minWidth: double.infinity,
                    ),
                    decoration: const BoxDecoration(
                      color: kOnPrimary,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(kDefaultButtonRadius),
                        topRight: Radius.circular(kDefaultButtonRadius),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(kDefaultPadding),
                      child: Column(
                        spacing: kDefaultGap,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TodaySalesInformation(),
                          HomeButtonsRow(),
                          LastSalesWidget(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
