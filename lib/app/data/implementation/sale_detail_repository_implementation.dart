import '../../domain/models/sale_detail.dart';
import '../../domain/repositories/database_repository.dart';
import '../../domain/repositories/sale_detail_repository.dart';

class SaleDetailImplementation implements SaleDetailRepository {
  SaleDetailImplementation({
    required this.databaseImplementation,
  });

  DatabaseRepository? databaseImplementation;
  final String tableName = 'Sale_Detail';

  @override
  Future<bool> deleteSaleDetail(
      {String? where, List<Object>? whereArgs}) async {
    final int? response = await databaseImplementation?.delete(
      table: tableName,
      where: where,
      whereArgs: whereArgs,
    );
    if (response == null || response == 0) {
      return false;
    }
    return true;
  }

  @override
  Future<SaleDetail?> getSaleDetail({
    String? where,
    List<Object>? whereArgs,
    String? orderBy,
    int? limit,
  }) async {
    final response = await databaseImplementation?.getFrom(
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
      return Future.error('Not SaleDetail');
    }
    return SaleDetail.fromMap(response.first);
  }

  @override
  Future<List<SaleDetail>?> getSaleDetails({
    String? where,
    List<Object>? whereArgs,
    String? orderBy,
    int? limit,
  }) async {
    final response = await databaseImplementation?.getAllFrom(
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
      return Future.error('Not SaleDetail');
    }
    List<SaleDetail> saleDetails = [];
    for (Map<String, Object?> saleDetail in response) {
      saleDetails.add(
        SaleDetail.fromMap(saleDetail),
      );
    }
    return saleDetails;
  }

  @override
  Future<bool> insert({required SaleDetail row}) async {
    final int? response = await databaseImplementation?.insertInto(
      table: tableName,
      row: row.toMap(),
    );
    if (response == null || response == 0) {
      return false;
    }
    return true;
  }

  @override
  Future<bool> update({
    required SaleDetail row,
    String? where,
    List<Object>? whereArgs,
  }) async {
    final int? response = await databaseImplementation?.update(
      table: tableName,
      row: row.toMap(),
      where: where,
      whereArgs: whereArgs,
    );
    if (response == null || response == 0) {
      return false;
    }
    return true;
  }
}
