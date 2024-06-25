import 'package:flutter/material.dart';

class SalesSummaryWidget extends StatelessWidget {
  final double totalSales;
  final int numberOfTransactions;
  final double averageSale;

  const SalesSummaryWidget({
    super.key,
    required this.totalSales,
    required this.numberOfTransactions,
    required this.averageSale,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 20.0,
            children: [
              _buildSummaryItem(
                  'Total de Ventas', '\$${totalSales.toStringAsFixed(2)}'),
              _buildSummaryItem(
                  'Número de Transacciones', numberOfTransactions.toString()),
              _buildSummaryItem(
                  'Venta Promedio', '\$${averageSale.toStringAsFixed(2)}'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: _labelTextStyle,
        ),
        const SizedBox(height: 5.0),
        Text(
          value,
          style: _valueTextStyle,
        ),
      ],
    );
  }

  TextStyle get _labelTextStyle {
    return const TextStyle(
      color: Colors.white,
      fontSize: 16.0,
    );
  }

  TextStyle get _valueTextStyle {
    return const TextStyle(
      color: Colors.white,
      fontSize: 18.0,
      fontWeight: FontWeight.bold,
    );
  }
}
