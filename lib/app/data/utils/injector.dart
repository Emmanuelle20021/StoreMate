import 'package:flutter/material.dart';

import '../../domain/repositories/product_repository.dart';
import '../../domain/repositories/sale_detail_repository.dart';
import '../../domain/repositories/sale_repository.dart';

class Injector extends InheritedWidget {
  final ProductRepository productRepository;
  final SaleRepository saleRepository;
  final SaleDetailRepository saleDetailRepository;

  const Injector({
    super.key,
    required super.child,
    required this.productRepository,
    required this.saleDetailRepository,
    required this.saleRepository,
  });

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;

  static Injector of(BuildContext context) {
    final Injector? injector =
        context.dependOnInheritedWidgetOfExactType<Injector>();
    assert(injector != null, 'No Injector found in context');
    return injector!;
  }
}
