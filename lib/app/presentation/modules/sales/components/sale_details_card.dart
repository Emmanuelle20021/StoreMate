import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_mate/app/domain/models/sale_detail.dart';
import 'package:store_mate/app/presentation/bloc/sale_detail_cubit.dart';
import 'package:store_mate/app/presentation/bloc/total_amount_sale.dart';

import '../../../../data/utils/constants/themes.dart';
import '../../../../domain/models/product.dart';

class SaleDetailCard extends StatefulWidget {
  const SaleDetailCard({
    super.key,
    required this.product,
    required this.index,
  });

  final Product product;
  final int index;

  @override
  State<SaleDetailCard> createState() => _SaleDetailCardState();
}

class _SaleDetailCardState extends State<SaleDetailCard> {
  TextEditingController quantityController = TextEditingController();

  void changeTotalAmount(
    BuildContext context,
    double oldAmount,
    double newAmount,
  ) {
    final currentTotal = context.read<TotalAmountSaleCubit>().state - oldAmount;
    context.read<TotalAmountSaleCubit>().changeTotalAmount(
          currentTotal + newAmount,
        );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SaleDetailCubit, List<SaleDetail>>(
      builder: (context, saleDetailState) {
        final saleDetail = saleDetailState[widget.index];
        double total = saleDetail.quantity * widget.product.price;
        return ListTile(
          title: Text(
            widget.product.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: kSmallText,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text('Subtotal: \$$total'),
          leading: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              // Remove product from sale
              final details = saleDetailState.toList();
              details.removeAt(widget.index);
              context.read<SaleDetailCubit>().changeDetails(details);
              context.read<TotalAmountSaleCubit>().subtractAmount(total);
            },
            color: kError,
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: () {
                  if (saleDetail.quantity == 1) {
                    return;
                  }
                  final newSaleDetail = saleDetail.copyWith(
                    quantity: saleDetail.quantity - 1,
                  );
                  context
                      .read<TotalAmountSaleCubit>()
                      .subtractAmount(widget.product.price);
                  context.read<SaleDetailCubit>().updateSaleDetail(
                        newSaleDetail,
                        widget.index,
                      );
                },
                color: kPrimary,
              ),
              SizedBox(
                width: 50,
                child: TextField(
                  textAlign: TextAlign.center,
                  controller: quantityController
                    ..text = saleDetail.quantity.toString(),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      if (int.parse(value) < 1) {
                        value = '1';
                      }
                      final oldTotal = total;
                      final newQuantity = int.parse(value);
                      final SaleDetail newSaleDetail =
                          saleDetail.copyWith(quantity: newQuantity);
                      final newTotal =
                          newSaleDetail.quantity * widget.product.price;
                      changeTotalAmount(
                        context,
                        oldTotal,
                        newTotal,
                      );
                      context.read<SaleDetailCubit>().updateSaleDetail(
                            newSaleDetail,
                            widget.index,
                          );
                    }
                  },
                  onTapOutside: (event) => FocusScope.of(context).unfocus(),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  final newQuantity = saleDetail.quantity + 1;
                  final newSaleDetail =
                      saleDetail.copyWith(quantity: newQuantity);
                  context
                      .read<TotalAmountSaleCubit>()
                      .addAmount(widget.product.price);
                  context.read<SaleDetailCubit>().updateSaleDetail(
                        newSaleDetail,
                        widget.index,
                      );
                },
                color: kCheckColor,
              ),
            ],
          ),
        );
      },
    );
  }
}
