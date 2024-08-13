import '../models/product.dart';

abstract class ProductRepository {
  Future<Product?> getProduct({
    String? where,
    List<Object>? whereArgs,
    String? orderBy,
    int? limit,
  });
  Future<List<Product>?> getProducts({
    String? where,
    List<Object>? whereArgs,
    String? orderBy,
    int? limit,
  });
  Future<bool> deleteProduct({
    String? where,
    List<Object>? whereArgs,
  });
  Future<bool> update({
    required Product row,
    String? where,
    List<Object>? whereArgs,
  });
  Future<bool> insert({
    required Product row,
  });
}
