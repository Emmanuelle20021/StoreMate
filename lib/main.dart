import 'package:flutter/material.dart';
import 'package:store_mate/constants/themes.dart';
import 'package:store_mate/screens/home_screen.dart';
import 'package:store_mate/screens/new_product_screen.dart';
import 'package:store_mate/screens/new_sale_screen.dart';
import 'package:store_mate/screens/products_screen.dart';
// import 'package:store_mate/screens/sales_screen.dart';

void main() {
  runApp(const ShopMate());
}

class ShopMate extends StatelessWidget {
  const ShopMate({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StoreMate',
      home: const MainScreen(),
      themeMode: ThemeMode.system,
      theme: lightTheme,
      darkTheme: darkTheme,
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final _pageController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _currentIndex == 0 ? _newSale : _newProduct,
        tooltip: _currentIndex == 0 ? 'Nueva venta' : 'Nuevo producto',
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(
          Icons.add,
          semanticLabel: _currentIndex == 0 ? 'Nueva venta' : 'Nuevo producto',
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: PageView(
        controller: _pageController,
        children: const [
          HomeScreen(),
          ProductListScreen(),
        ],
        onPageChanged: (index) => _changePage(index),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => _changePage(index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Productos',
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

  void _newSale() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const NewSaleScreen(),
      ),
    );
  }

  void _newProduct() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const NewProductScreen(),
      ),
    );
  }
}
