import 'package:flutter/material.dart';
import 'package:store_mate/app/domain/repositories/sale_detail_repository.dart';

import '../../../../data/utils/constants/constants.dart';
import '../../../../data/utils/constants/themes.dart';
import '../../../../data/utils/injector.dart';
import '../../../../domain/models/sale.dart';
import '../../../../domain/models/sale_detail.dart';
import '../../../../domain/repositories/product_repository.dart';

class SaleDetailScreen extends StatelessWidget {
  const SaleDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Sale? sale = ModalRoute.of(context)?.settings.arguments as Sale?;
    final DateTime date = DateTime.parse(sale?.date ?? '');
    SaleDetailRepository saleDetailRepository =
        Injector.of(context).saleDetailRepository;
    ProductRepository productRepository =
        Injector.of(context).productRepository;
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: kPrimary,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: kNoColor,
        title: const Text(
          'Detalle de Venta',
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
              padding: const EdgeInsets.all(kDefaultPadding),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: kBackground,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FittedBox(
                    child: Text(
                      'Venta ${date.day}-${date.month}-${date.year} ${date.hour}:${date.minute}',
                      style: const TextStyle(
                        color: kTextColor,
                        fontSize: kExtraLargeText,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total: ',
                        style: TextStyle(
                          fontSize: kMediumText,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '\$${sale?.totalAmount.toStringAsFixed(2)}',
                        style: const TextStyle(
                          color: kPrimary,
                          fontSize: kMediumText,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: kDefaultGap,
                  ),
                  const Text(
                    'Productos Vendidos',
                    style: TextStyle(
                      color: kTextColor,
                      fontSize: kExtraLargeText,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: FutureBuilder(
                        future: saleDetailRepository.getSaleDetails(
                          where: 'sale_id = ?',
                          whereArgs: [sale!.id!],
                        ),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (snapshot.hasError) {
                            return const Center(
                              child: Text('Error al cargar los datos'),
                            );
                          }
                          if (snapshot.hasData && snapshot.data!.isEmpty) {
                            return const Center(
                              child: Text('No hay productos vendidos'),
                            );
                          }
                          final List<SaleDetail>? saleDetails = snapshot.data;
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: saleDetails?.length,
                            itemBuilder: (context, index) {
                              final SaleDetail saleDetail = saleDetails![index];
                              return FutureBuilder(
                                future: productRepository.getProduct(
                                  where: 'product_id = ?',
                                  whereArgs: [saleDetail.productId],
                                ),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                  if (snapshot.hasError) {
                                    return const Center(
                                      child: Text('Error al cargar los datos'),
                                    );
                                  }
                                  final product = snapshot.data;
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: kDefaultPadding,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          product!.name,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            color: kTextColor,
                                            fontSize: kLargeText,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          'Cantidad: ${saleDetail.quantity}',
                                          style: const TextStyle(
                                            color: kTextColor,
                                            fontSize: kMediumText,
                                          ),
                                        ),
                                        Text(
                                          'Precio unitario: \$${product.price}',
                                          style: const TextStyle(
                                            color: kTextColor,
                                            fontSize: kMediumText,
                                          ),
                                        ),
                                        Text(
                                          'Total: \$${product.price * saleDetail.quantity}',
                                          style: const TextStyle(
                                            color: kPrimary,
                                            fontSize: kMediumText,
                                          ),
                                        ),
                                        const Divider(
                                          color: kTextColor,
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        },
                      ),
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
