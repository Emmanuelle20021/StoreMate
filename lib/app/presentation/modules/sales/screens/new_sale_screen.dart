// ignore_for_file: use_build_context_synchronously

import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_mate/app/data/utils/constants/constants.dart';
import 'package:store_mate/app/data/utils/injector.dart';
import 'package:store_mate/app/domain/models/sale_detail.dart';
import 'package:store_mate/app/domain/models/summary_data.dart';
import 'package:store_mate/app/domain/repositories/sale_repository.dart';
import 'package:store_mate/app/presentation/bloc/blocs.dart';
import 'package:store_mate/app/presentation/bloc/last_sales_cubit.dart';
import 'package:store_mate/app/presentation/bloc/products_cubit.dart';
import 'package:store_mate/app/presentation/bloc/sale_detail_cubit.dart';
import 'package:store_mate/app/presentation/bloc/sales_cubit.dart';
import 'package:store_mate/app/presentation/bloc/total_amount_sale.dart';

import '../../../../data/utils/constants/themes.dart';
import '../../../../domain/models/product.dart';
import '../../../../domain/models/sale.dart';
import '../../../../domain/repositories/sale_detail_repository.dart';
import '../components/sale_details_card.dart';

class NewSaleScreen extends StatefulWidget {
  const NewSaleScreen({super.key});

  @override
  State<NewSaleScreen> createState() => _NewSaleScreenState();
}

class _NewSaleScreenState extends State<NewSaleScreen> {
  Product? selected;
  bool enable = true;

  @override
  Widget build(BuildContext context) {
    String displayStringForOption(Product option) => option.name;

    return Scaffold(
      backgroundColor: kPrimary,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: kNoColor,
        title: const Text(
          'Nueva Venta',
          style: TextStyle(
            color: kOnPrimary,
            fontSize: kLargeText,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          ...kCircleDecorations,
          SafeArea(
            child: Container(
              constraints: const BoxConstraints.expand(),
              decoration: const BoxDecoration(
                color: kBackground,
              ),
              padding: const EdgeInsets.all(kDefaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Añadir un producto a la venta',
                    style: TextStyle(
                      color: kOnBackground,
                      fontSize: kLargeText,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: kDefaultGap),
                  SizedBox(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: BlocBuilder<ProductsCubit, List<Product>>(
                            builder: (context, productsState) {
                              return Autocomplete<Product>(
                                fieldViewBuilder: (
                                  context,
                                  textEditingController,
                                  focusNode,
                                  onFieldSubmitted,
                                ) {
                                  return TextFormField(
                                    controller: textEditingController,
                                    focusNode: focusNode,
                                    decoration: const InputDecoration(
                                      hintText: 'Buscar producto',
                                      border: OutlineInputBorder(),
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: kDefaultPadding,
                                        vertical: kDefaultPadding / 2,
                                      ),
                                    ),
                                  );
                                },
                                onSelected: (option) {
                                  setState(() {
                                    selected = option;
                                  });
                                },
                                displayStringForOption: displayStringForOption,
                                optionsBuilder: (textEditingValue) {
                                  if (textEditingValue.text == '') {
                                    return productsState;
                                  }
                                  return productsState.where(
                                    (Product option) {
                                      return option.name.toLowerCase().contains(
                                          textEditingValue.text.toLowerCase());
                                    },
                                  );
                                },
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          width: kDefaultGap,
                        ),
                        ElevatedButton.icon(
                          onPressed: _addProductToSale,
                          icon: const Icon(Icons.add),
                          label: const Text('Agregar'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: kDefaultGap),
                  Stack(
                    children: [
                      Divider(
                        color:
                            kOnBackground.withOpacity(kDefaultOverlayOpacity),
                        thickness: 1,
                      ),
                      Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: kDefaultPadding,
                          ),
                          decoration: const BoxDecoration(
                            color: kBackground,
                          ),
                          child: const Text(
                            'ó',
                            style: TextStyle(
                              color: kOnBackground,
                              fontSize: kLargeText,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: kDefaultGap),
                  Center(
                    child: OutlinedButton(
                      onPressed: () async {
                        ScanResult response = await BarcodeScanner.scan();
                        setState(() {
                          selected =
                              context.read<ProductsCubit>().state.firstWhere(
                                    (product) =>
                                        product.id.toString() ==
                                        response.rawContent.toString(),
                                  );
                        });
                        _addProductToSale();
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                          color: kPrimary,
                          width: 2,
                        ),
                      ),
                      child: const Text('Escanear QR'),
                    ),
                  ),
                  const SizedBox(height: kDefaultGap),
                  Expanded(
                    child: BlocBuilder<SaleDetailCubit, List<SaleDetail>>(
                      builder: (context, detailsState) {
                        return detailsState.isEmpty
                            ? const Center(
                                child: Text(
                                  'Aun no hay productos en la venta',
                                  style: TextStyle(
                                    color: kTextColor,
                                    fontSize: kLargeText,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            : ListView.builder(
                                itemCount: detailsState.length,
                                itemBuilder: (context, index) {
                                  Product product = context
                                      .read<ProductsCubit>()
                                      .state
                                      .firstWhere(
                                        (product) =>
                                            product.id ==
                                            detailsState[index].productId,
                                      );
                                  return SaleDetailCard(
                                    product: product,
                                    index: index,
                                  );
                                },
                              );
                      },
                    ),
                  ),
                  BlocBuilder<TotalAmountSaleCubit, double>(
                    builder: (context, totalAmountSaleState) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total: \$${totalAmountSaleState.toStringAsFixed(2)}',
                            style: const TextStyle(
                              color: kOnBackground,
                              fontSize: kLargeText,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          ElevatedButton.icon(
                            onPressed: () async {
                              if (enable) {
                                bool response = await _saveNewSale(context);
                                if (mounted) {
                                  createDialog(context, response).then(
                                    (_) => {
                                      if (!enable)
                                        {
                                          Navigator.pop(context),
                                        }
                                    },
                                  );
                                }
                              }
                            },
                            icon: const Icon(Icons.save),
                            label: const Text('Guardar'),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> createDialog(BuildContext context, bool response) {
    if (response) {
      return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text(
            'Venta guardada',
            style: TextStyle(
              color: kTextColor,
              fontSize: kExtraLargeText,
            ),
          ),
          icon: const Icon(
            Icons.check,
            size: kCircleDecorationSmallSize,
          ),
          iconColor: kPrimary,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Aceptar'),
            ),
          ],
        ),
      );
    } else {
      enable = true;
      return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            alignment: Alignment.center,
            icon: const Icon(
              Icons.info,
              color: kPrimary,
              size: kCircleDecorationSmallSize,
            ),
            title: const Text('¡Algo salió mal!'),
            content: const Text(
              'No se pudo agregar la venta.',
              textAlign: TextAlign.center,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Aceptar'),
              ),
            ],
          );
        },
      );
    }
  }

  Future<bool> _saveNewSale(BuildContext context) async {
    enable = false;
    DateTime date = DateTime.now();
    Sale newSale = Sale(
      date: date.toString(),
      totalAmount: context.read<TotalAmountSaleCubit>().state,
      enable: 1,
    );
    SaleRepository saleRepository = Injector.of(context).saleRepository;

    try {
      bool isSaved = await saleRepository.insert(row: newSale);

      if (isSaved) {
        Sale? saleWithId = await saleRepository.getSale(
          where: 'sale_creation_date = ?',
          whereArgs: [
            date.toString(),
          ],
        );
        if (saleWithId != null && mounted) {
          SaleDetailRepository saleDetailRepository =
              Injector.of(context).saleDetailRepository;
          final List<SaleDetail> saleDetails =
              context.read<SaleDetailCubit>().state;
          for (var detail in saleDetails) {
            final detailWithId = detail.copyWith(saleId: saleWithId.id);
            await saleDetailRepository.insert(row: detailWithId);
          }

          if (mounted) {
            final List<Sale> sales = context.read<SalesCubit>().state.toList();
            sales.add(saleWithId);
            final SummaryData oldProfit =
                context.read<TodayProfitCubit>().state;

            final totalAmount = oldProfit.totalAmount +
                context.read<TotalAmountSaleCubit>().state;
            final newProfit = SummaryData(
              sales: sales.length,
              totalAmount: totalAmount,
              lastTime: TimeOfDay.fromDateTime(date),
            );
            context.read<TodayProfitCubit>().changeProfit(newProfit);
            context.read<SalesCubit>().changeSales(sales);
            context.read<LastSalesCubit>().updateLastSales(newSale);
            context.read<SaleDetailCubit>().changeDetails([]);
            context.read<TotalAmountSaleCubit>().changeTotalAmount(0);
          }
          return true;
        }
      }
      enable = true;
      return false;
    } catch (exception) {
      //
      if (mounted) createDialog(context, false);
      enable = true;
      return false;
    }
  }

  void _addProductToSale() {
    if (selected != null) {
      // Add product to sale
      SaleDetail newSaleDetail = SaleDetail(
        productId: selected!.id!,
        quantity: 1,
        saleId: 0,
      );
      final List<SaleDetail> details =
          context.read<SaleDetailCubit>().state.toList();
      bool isAlreadyInSale = details.any(
        (element) => element.productId == selected!.id,
      );
      if (isAlreadyInSale) {
        return;
      }
      details.add(newSaleDetail);
      context.read<TotalAmountSaleCubit>().addAmount(selected!.price);
      context.read<SaleDetailCubit>().changeDetails(details);
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            alignment: Alignment.center,
            icon: const Icon(
              Icons.info,
              color: kPrimary,
              size: kCircleDecorationSmallSize,
            ),
            title: const Text('¡Vaya!'),
            content: const Text(
              'Debes seleccionar un producto.',
              textAlign: TextAlign.center,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Aceptar'),
              ),
            ],
          );
        },
      );
    }
  }
}
