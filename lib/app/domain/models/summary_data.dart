import 'package:flutter/material.dart';

class SummaryData {
  int sales;
  double totalAmount;
  TimeOfDay lastTime;

  SummaryData({
    required this.sales,
    required this.totalAmount,
    required this.lastTime,
  });

  set setSales(int sales) {
    this.sales = sales;
  }

  set setTotalAmount(double totalAmount) {
    this.totalAmount = totalAmount;
  }

  set setLastTime(TimeOfDay lastTime) {
    this.lastTime = lastTime;
  }
}
