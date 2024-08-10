import 'package:flutter/material.dart';
import 'package:store_mate/app/presentation/modules/home/screens/home_screen.dart';

import '../modules/products/screens/new_product_screen.dart';
import '../modules/products/screens/products_screen.dart';
import '../modules/sales/screens/new_sale_screen.dart';
import 'routes.dart';

Map<String, Widget Function(BuildContext)> get appRoutes {
  return {
    Routes.home: (context) => const HomeScreen(),
    Routes.products: (context) => const ProductsScreen(),
    Routes.newProduct: (context) => const NewProductScreen(),
    Routes.sales: (context) => const Center(
          child: Text(Routes.sales),
        ),
    Routes.newSale: (context) => const NewSaleScreen(),
  };
}
