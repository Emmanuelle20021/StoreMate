import 'package:flutter_bloc/flutter_bloc.dart';

class TotalAmountSaleCubit extends Cubit<double> {
  TotalAmountSaleCubit() : super(0.0);

  changeTotalAmount(double amount) {
    emit(amount);
  }

  void addAmount(double amount) {
    emit(state + amount);
  }

  void subtractAmount(double amount) {
    emit(state - amount);
  }
}
