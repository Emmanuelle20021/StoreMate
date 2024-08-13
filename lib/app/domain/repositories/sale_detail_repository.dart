import '../models/sale_detail.dart';

abstract class SaleDetailRepository {
  Future<SaleDetail?> getSaleDetail({
    String? where,
    List<Object>? whereArgs,
    String? orderBy,
    int? limit,
  });
  Future<List<SaleDetail>?> getSaleDetails({
    String? where,
    List<Object>? whereArgs,
    String? orderBy,
    int? limit,
  });
  Future<bool> deleteSaleDetail({
    String? where,
    List<Object>? whereArgs,
  });
  Future<bool> update({
    required SaleDetail row,
    String? where,
    List<Object>? whereArgs,
  });
  Future<bool> insert({
    required SaleDetail row,
  });
}
