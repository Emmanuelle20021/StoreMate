import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_mate/app/data/utils/constants/themes.dart';
import 'package:store_mate/app/domain/models/summary_data.dart';
import 'package:store_mate/app/domain/repositories/sale_repository.dart';
import 'package:store_mate/app/presentation/bloc/today_profit_cubit.dart';
import 'package:store_mate/app/presentation/bloc/sales_cubit.dart';
import 'package:store_mate/app/presentation/routes/routes.dart';

import '../../../../data/utils/constants/constants.dart';
import '../../../../data/utils/injector.dart';
import '../../../../domain/models/product.dart';
import '../../../../domain/models/sale.dart';
import '../../../../domain/repositories/product_repository.dart';
import '../../../bloc/products_cubit.dart';
import '../../../global/widgets/card_button.dart';
import '../../../global/widgets/light_primary_button.dart';
import '../../../global/widgets/sale_card.dart';
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
  }

  Future<void> _initData() async {
    try {
      SaleRepository saleRepository = Injector.of(context).saleRepository;
      ProductRepository productRepository =
          Injector.of(context).productRepository;
      SummaryData? todayProfit = await saleRepository.todaySales();
      List<Sale>? sales = await saleRepository.getSales();
      List<Product>? responseProducts = await productRepository.getProducts();
      if (mounted) {
        context.read<TodayProfitCubit>().changeProfit(todayProfit);
        if (responseProducts != null) {
          context.read<ProductsCubit>().changeProducts(responseProducts);
        }
        if (sales != null) {
          context.read<SalesCubit>().changeSales(sales);
        }
      }
    } catch (e) {
      //
    }
  }

  @override
  Widget build(BuildContext context) {
    TodayProfitCubit todayProfitCubit = context.watch<TodayProfitCubit>();
    SalesCubit salesCubit = context.watch<SalesCubit>();

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
              children: [
                const SizedBox(height: kDefaultGap),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child: RichText(
                    text: const TextSpan(
                      style: TextStyle(
                        fontSize: kLargeText,
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        TextSpan(
                          text: '¡Bienvenido de nuevo! \n',
                          style: TextStyle(color: kOnPrimary),
                        ),
                        TextSpan(
                          text: 'Continuemos con las ventas.',
                          style: TextStyle(color: kSecondary),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: kDefaultGap),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                                  text:
                                      '\$${todayProfitCubit.state.totalAmount.toStringAsFixed(2)}',
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
                                todayProfitCubit.state.sales.toString(),
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
                                todayProfitCubit.state.lastTime.format(context),
                                style: const TextStyle(
                                  color: kPrimary,
                                  fontSize: kMediumText,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: kDefaultGap),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CardButton(
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
                          ),
                          const SizedBox(height: kDefaultGap),
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
                                if (salesCubit.state.isEmpty) {
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
                                    itemCount: salesCubit.state.length,
                                    itemBuilder: (context, index) {
                                      return SaleCard(
                                        sale: salesCubit.state[index],
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
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
