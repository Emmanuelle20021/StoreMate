import 'package:flutter/material.dart';
import 'package:store_mate/constants/themes.dart';

void main() {
  runApp(const ShopMate());
}

class ShopMate extends StatelessWidget {
  const ShopMate({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StoreMate',
      home: const HomeScreen(),
      themeMode: ThemeMode.system,
      theme: lightTheme,
      darkTheme: darkTheme,
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final _pageController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: const [
          SalesScreen(),
          Center(
            child: Text('Welcome to page 2'),
          ),
          Center(
            child: Text('Welcome to page 3'),
          ),
        ],
        onPageChanged: (index) => _changePage(index),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => _changePage(index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Productos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Configuración',
          ),
        ],
      ),
    );
  }

  void _changePage(int index) {
    setState(() {
      _pageController.jumpToPage(index);
      _currentIndex = index;
    });
  }
}

class SalesScreen extends StatefulWidget {
  const SalesScreen({super.key});

  @override
  State<SalesScreen> createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ventas'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            SalesSummaryWidget(
              totalSales: 100,
              numberOfTransactions: 21,
              averageSale: 50,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Nueva venta',
        child: const Icon(Icons.add),
      ),
    );
  }
}

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
        color: Colors.blue,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Resumen de Ventas',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10.0),
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
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
        const SizedBox(height: 5.0),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
