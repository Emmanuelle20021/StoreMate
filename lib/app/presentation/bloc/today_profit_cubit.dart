import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_mate/app/domain/models/summary_data.dart';

class TodayProfitCubit extends Cubit<SummaryData> {
  TodayProfitCubit()
      : super(
          SummaryData(
            sales: 0,
            totalAmount: 0,
            lastTime: TimeOfDay.now(),
          ),
        );

  void changeProfit(SummaryData profit) {
    emit(profit);
  }
}
