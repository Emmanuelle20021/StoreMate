import 'package:flutter/material.dart';
import 'package:store_mate/app/domain/models/product.dart';
import 'package:store_mate/app/domain/repositories/database_repository.dart';
import 'package:store_mate/app/domain/repositories/product_repository.dart';

class ProductImplementation implements ProductRepository {
  ProductImplementation({
    required this.databaseImplementation,
  });

  DatabaseRepository databaseImplementation;
  final String tableName = 'Product';

  @override
  Future<bool> deleteProduct({String? where, List<Object>? whereArgs}) async {
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
  Future<Product?> getProduct({
    String? where,
    List<Object>? whereArgs,
    String? orderBy,
    int? limit,
  }) async {
    final response = await databaseImplementation.getFrom(
      table: tableName,
      limit: limit,
      orderBy: orderBy,
      where: where ?? 'product_enable = 1',
      whereArgs: whereArgs,
    );
    if (response == null) {
      return Future.error('Not Product');
    }
    return Product.fromMap(response.first);
  }

  @override
  Future<List<Product>?> getProducts({
    String? where,
    List<Object>? whereArgs,
    String? orderBy,
    int? limit,
  }) async {
    final response = await databaseImplementation.getAllFrom(
      table: tableName,
      limit: limit,
      orderBy: orderBy,
      where: where ?? 'product_enable = 1',
      whereArgs: whereArgs,
    );

    if (response == null) {
      return [];
    }
    List<Product> products = [];
    for (Map<String, Object?> product in response) {
      debugPrint('product: $product');
      products.add(
        Product.fromMap(product),
      );
    }
    return products;
  }

  @override
  Future<bool> insert({required Product row}) async {
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
    required Product row,
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
}
