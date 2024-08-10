import 'package:flutter/material.dart';

class SalesList extends StatelessWidget {
  final List<SalesCard> sales;

  const SalesList({super.key, required this.sales});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: sales.length,
      itemBuilder: (context, index) {
        return sales[index];
      },
    );
  }
}

class SalesCard extends StatelessWidget {
  final double totalAmount;
  final String date;

  const SalesCard({
    super.key,
    required this.totalAmount,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Venta del $date',
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Divider(color: Colors.grey[400]),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '\$${totalAmount.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
