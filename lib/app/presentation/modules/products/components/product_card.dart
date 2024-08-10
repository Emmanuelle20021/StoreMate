import 'package:flutter/material.dart';

import '../../../../domain/models/product.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    required this.product,
    super.key,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(product.name),
      subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).hintColor,
        child: Text(product.name[0]),
      ),
      trailing: FittedBox(
        child: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.remove),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
