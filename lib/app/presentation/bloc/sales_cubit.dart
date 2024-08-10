import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_mate/app/domain/models/sale.dart';

class SalesCubit extends Cubit<List<Sale>> {
  SalesCubit() : super([]);

  void changeSales(List<Sale> sales) {
    emit(sales);
  }
}
