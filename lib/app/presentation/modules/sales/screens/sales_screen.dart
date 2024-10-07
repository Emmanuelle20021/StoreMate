import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_mate/app/data/utils/constants/constants.dart';
import 'package:store_mate/app/data/utils/injector.dart';
import 'package:store_mate/app/domain/models/sale.dart';
import 'package:store_mate/app/domain/repositories/sale_repository.dart';
import 'package:store_mate/app/presentation/global/widgets/sale_card.dart';

import '../../../../data/utils/constants/themes.dart';
import '../../../bloc/sales_cubit.dart';
import '../../../routes/routes.dart';

class SalesScreen extends StatefulWidget {
  const SalesScreen({super.key});

  @override
  State<SalesScreen> createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SaleRepository saleRepository = Injector.of(context).saleRepository;
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: kPrimary,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: kNoColor,
        title: const Text(
          'Ventas realizadas',
          style: TextStyle(
            color: kOnPrimary,
          ),
        ),
      ),
      body: Stack(
        children: [
          ...kCircleDecorations,
          SafeArea(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              decoration: const BoxDecoration(
                color: kBackground,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                          fixedSize: WidgetStateProperty.all(
                            const Size(50, 50),
                          ),
                          padding: WidgetStateProperty.all(
                            const EdgeInsets.all(kNone),
                          ),
                          alignment: Alignment.center,
                          backgroundColor: WidgetStateProperty.all(
                            kContainer,
                          ),
                          shape: WidgetStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                kDefaultButtonRadius,
                              ),
                            ),
                          ),
                        ),
                        onPressed: () => Navigator.pushNamed(
                          context,
                          Routes.newSale,
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.add,
                            size: 30,
                          ),
                        ),
                      ),
                      AnimSearchBar(
                        width: MediaQuery.of(context).size.width - 100,
                        textController: searchController,
                        onSuffixTap: () async {
                          searchController.clear();
                          context.read<SalesCubit>().changeSales(
                                await saleRepository.getSales() ?? [],
                              );
                        },
                        onSubmitted: (value) {
                          List<Sale> filteredSales = context
                              .read<SalesCubit>()
                              .state
                              .where(
                                (element) => element.date
                                    .toLowerCase()
                                    .contains(value.toLowerCase()),
                              )
                              .toList();
                          context.read<SalesCubit>().changeSales(filteredSales);
                        },
                        color: kPrimary,
                        searchIconColor: kOnPrimary,
                        textFieldColor: kPrimary.withOpacity(.6),
                        textFieldIconColor: kOnPrimary,
                        helpText: 'Buscar ventas...',
                        boxShadow: false,
                        style: const TextStyle(
                          color: kOnPrimary,
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: BlocBuilder<SalesCubit, List<Sale>>(
                      builder: (context, salesState) {
                        if (salesState.isEmpty) {
                          return const Center(
                            child: Text(
                              'No hay ventas disponibles',
                              style: TextStyle(
                                color: kOnSurface,
                                fontSize: kMediumText,
                              ),
                            ),
                          );
                        } else {
                          return ListView.builder(
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
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
