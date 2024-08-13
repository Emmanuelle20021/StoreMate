import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_mate/app/domain/models/product.dart';

class ProductsCubit extends Cubit<List<Product>> {
  ProductsCubit() : super([]);

  void changeProducts(List<Product> products) {
    emit(products);
  }
}
