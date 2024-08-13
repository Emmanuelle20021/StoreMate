import '../models/sale.dart';
import '../models/summary_data.dart';

abstract class SaleRepository {
  Future<Sale?> getSale({
    String? where,
    List<Object>? whereArgs,
    String? orderBy,
    int? limit,
  });
  Future<List<Sale>?> getSales({
    String? where,
    List<Object>? whereArgs,
    String? orderBy,
    int? limit,
  });
  Future<bool> deleteSale({
    String? where,
    List<Object>? whereArgs,
  });
  Future<bool> update({
    required Sale row,
    String? where,
    List<Object>? whereArgs,
  });
  Future<bool> insert({
    required Sale row,
  });
  Future<SummaryData> todaySales();
}
