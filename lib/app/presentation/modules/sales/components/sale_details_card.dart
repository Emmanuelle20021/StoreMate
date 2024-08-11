import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../data/utils/constants/themes.dart';
import '../../../../domain/models/product.dart';

class SaleDetailCard extends StatefulWidget {
  const SaleDetailCard({
    super.key,
    required this.product,
    required this.onPressed,
  });

  final Product product;
  final Function() onPressed;

  @override
  State<SaleDetailCard> createState() => _SaleDetailCardState();
}

class _SaleDetailCardState extends State<SaleDetailCard> {
  int quantity = 1;
  double total = 0;
  TextEditingController quantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
      subtitle: Text('Subtotal: \$${quantity * widget.product.price}'),
      leading: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: widget.onPressed,
        color: kError,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.remove),
            onPressed: () {
              if (quantity == 1) {
                return;
              }
              setState(() {
                quantity--;
              });
            },
            color: kPrimary,
          ),
          SizedBox(
            width: 50,
            child: TextField(
              textAlign: TextAlign.center,
              controller: quantityController..text = quantity.toString(),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              onChanged: (value) {
                setState(() {
                  quantity = int.parse(value);
                });
              },
              onTapOutside: (event) => FocusScope.of(context).unfocus(),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              setState(() {
                quantity++;
              });
            },
            color: kCheckColor,
          ),
        ],
      ),
    );
  }
}
