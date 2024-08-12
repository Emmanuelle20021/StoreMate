import 'package:flutter/material.dart';
import 'package:store_mate/app/domain/models/summary_data.dart';

import '../../domain/models/sale.dart';
import '../../domain/repositories/database_repository.dart';
import '../../domain/repositories/sale_repository.dart';

class SaleImplementation implements SaleRepository {
  SaleImplementation({
    required this.databaseImplementation,
  });

  DatabaseRepository databaseImplementation;
  final String tableName = 'Sale';

  @override
  Future<bool> deleteSale({String? where, List<Object>? whereArgs}) async {
    final int response = await databaseImplementation.delete(
      table: tableName,
      where: where,
      whereArgs: whereArgs,
    );
    if (response == 0) {
      return false;
    }
    return true;
  }

  @override
  Future<Sale?> getSale({
    String? where,
    List<Object>? whereArgs,
    String? orderBy,
    int? limit,
  }) async {
    final response = await databaseImplementation.getFrom(
      table: tableName,
      limit: limit,
      orderBy: orderBy,
      where: where,
      whereArgs: whereArgs,
    );
    if (response == null) {
      return null;
    }
    if (response == []) {
      return Future.error('Not Sale');
    }
    return Sale.fromMap(response.first);
  }

  @override
  Future<List<Sale>?> getSales({
    String? where,
    List<Object>? whereArgs,
    String? orderBy,
    int? limit,
  }) async {
    final response = await databaseImplementation.getAllFrom(
      table: tableName,
      limit: limit,
      orderBy: orderBy,
      where: where,
      whereArgs: whereArgs,
    );
    if (response == null) {
      return null;
    }
    if (response == []) {
      return Future.error('Not Sale');
    }
    List<Sale> sales = [];
    for (Map<String, Object?> sale in response) {
      sales.add(
        Sale.fromMap(sale),
      );
    }
    return sales;
  }

  @override
  Future<bool> insert({required Sale row}) async {
    final int response = await databaseImplementation.insertInto(
      table: tableName,
      row: row.toMap(),
    );

    if (response == 0) {
      return false;
    }
    return true;
  }

  @override
  Future<bool> update({
    required Sale row,
    String? where,
    List<Object>? whereArgs,
  }) async {
    final int response = await databaseImplementation.update(
      table: tableName,
      row: row.toMap(),
      where: where,
      whereArgs: whereArgs,
    );
    if (response == 0) {
      return false;
    }
    return true;
  }

  @override
  Future<SummaryData> todaySales() async {
    String today = DateTime.now().toString().substring(0, 10);
    final List<Map<String, Object?>>? sales =
        await databaseImplementation.getAllFrom(
      table: tableName,
      where: 'sale_enable = 1 and sale_creation_date LIKE "%$today%"',
    );
    double totalAmount = 0;
    if (sales == null || sales.isEmpty) {
      return SummaryData(
        sales: 0,
        totalAmount: 0,
        lastTime: TimeOfDay.now(),
      );
    }
    for (Map<String, Object?> element in sales) {
      Sale sale = Sale.fromMap(element);
      totalAmount += sale.totalAmount;
    }
    final Map<String, Object?> last = sales.last;
    return SummaryData(
      sales: sales.length,
      totalAmount: totalAmount,
      lastTime: TimeOfDay.fromDateTime(
        DateTime.parse(last['sale_creation_date'] as String),
      ),
    );
  }
}
