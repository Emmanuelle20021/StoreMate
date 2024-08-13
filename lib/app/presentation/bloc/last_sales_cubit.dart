import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_mate/app/domain/models/sale.dart';

class LastSalesCubit extends Cubit<List<Sale>> {
  LastSalesCubit() : super([]);

  changeLastSales(List<Sale> sales) {
    emit(sales);
  }

  updateLastSales(Sale sale) {
    final List<Sale> currentSales = state;
    currentSales.removeLast();
    currentSales.insert(0, sale);
    emit(currentSales);
  }
}
