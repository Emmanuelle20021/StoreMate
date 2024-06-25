import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
import 'package:store_mate/models/models.dart';

class StoreMateDatabase {
  static final StoreMateDatabase instance = StoreMateDatabase._init();

  static Database? _database;

  static const String productsTable = 'Product';
  static const String salesTable = 'Sale';
  static const String salesDetailsTable = 'Sale_Detail';
  static const String dbName = 'storemate.db';

  StoreMateDatabase._init();

  Future<Database?> get database async {
    _database = await _initDB(dbName);
    return _database;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = p.join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreateDB,
      onConfigure: _onConfigure,
    );
  }

  static Future _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  FutureOr<void> _onCreateDB(Database db, int version) async {
    await db.execute(
      '''CREATE TABLE `$productsTable` (
	    `product_id` INTEGER NOT NULL  UNIQUE,
	    `product_name` TEXT NOT NULL UNIQUE,
	    `product_category` TEXT NOT NULL,
	    `product_price` REAL NOT NULL,
	    `product_image_path` TEXT,
	    `product_qr_image_path` TEXT,
	    `product_description` TEXT,
	    `product_enable` INTEGER DEFAULT 1,
	    PRIMARY KEY(`product_id`)
      );''',
    );
    await db.execute(
      '''
      CREATE UNIQUE INDEX `Product_index_name`
      ON `$productsTable` (`product_name`);''',
    );
    await db.execute(
      '''CREATE INDEX `Product_index_category`
      ON `$productsTable` (`product_category`);''',
    );
    await db.execute(
      '''CREATE TABLE `$salesTable` (
	    `sale_id` INTEGER NOT NULL  UNIQUE,
	    `sale_creation_date` TEXT NOT NULL,
	    `sale_total_amount` REAL NOT NULL,
	    `sale_enable` INTEGER DEFAULT 1,
	    PRIMARY KEY(`sale_id`)
      );''',
    );
    await db.execute(
      '''CREATE INDEX `Sale_index_date`
      ON `$salesTable` (`sale_creation_date`);''',
    );

    await db.execute(
      '''CREATE TABLE `$salesDetailsTable` (
	    `detail_id` INTEGER NOT NULL  UNIQUE,
	    `product_id` INTEGER NOT NULL,
	    `sale_id` INTEGER NOT NULL,
	    `detail_size` TEXT,
	    `detail_color` TEXT,
	    `detail_quantity` INTEGER NOT NULL,
	    PRIMARY KEY(`detail_id`),
      FOREIGN KEY(`product_id`) REFERENCES `$productsTable`(`product_id`)
      ON UPDATE NO ACTION ON DELETE NO ACTION,
      FOREIGN KEY(`sale_id`) REFERENCES `$salesTable`(`sale_id`)
      ON UPDATE NO ACTION ON DELETE NO ACTION
      );''',
    );
  }

  Future<int> insertProduct(Product product) async {
    Map<String, Object?> map = product.toMap();
    final Database? db = await instance.database;
    return await db!.insert(
      productsTable,
      map,
    );
  }

  Future<int> insertSale(Sale sale) async {
    Map<String, Object?> map = sale.toMap();
    final Database? db = await instance.database;
    return await db!.insert(salesTable, map);
  }

  Future<int> insertSaleDetail(SaleDetail saleDetail) async {
    Map<String, Object?> map = saleDetail.toMap();
    final Database? db = await instance.database;
    return await db!.insert(salesDetailsTable, map);
  }

  Future<SummaryData> selectTodaySales() async {
    final Database? db = await instance.database;
    String today = DateTime.now().toString().substring(0, 10);
    final List<Map<String, Object?>> sales = await db!.query(
      salesTable,
      where: 'sale_enable = 1 and sale_creation_date = $today',
    );
    double totalAmount = 0;
    for (var element in sales) {
      totalAmount += element['sale_total_amount'] as double;
    }
    return Future.value(
      SummaryData(
        sales: sales.length,
        totalAmount: totalAmount,
        averageSale: totalAmount / sales.length,
      ),
    );
  }

  Future<List<Map<String, Object?>>> selectAllProducts() async {
    final Database? db = await instance.database;
    return db!.query(productsTable, where: 'product_enable = 1');
  }

  Future<Map<String, Object>> getDbPath() async {
    String dbPath = await getDatabasesPath();
    Directory? externalStoragePath = await getApplicationDocumentsDirectory();
    return {
      'dbPath': dbPath,
      'externalStoragePath': externalStoragePath.path,
    };
  }

  Future<void> backupDB() async {
    PermissionStatus status = await Permission.manageExternalStorage.status;
    if (!status.isGranted) {
      await Permission.manageExternalStorage.request();
    }
    PermissionStatus status2 = await Permission.storage.status;
    if (!status2.isGranted) {
      await Permission.storage.request();
    }
    final dbPath = await getDatabasesPath();
    try {
      File dbFile = File('$dbPath/$dbName');
      Directory? backubDirectory = Directory('/storage/emulated/0/storemate/');
      await backubDirectory.create();
      await dbFile.copy('${backubDirectory.path}/$dbName');
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  Future<void> restoreDB() async {
    PermissionStatus status = await Permission.manageExternalStorage.status;
    if (!status.isGranted) {
      await Permission.manageExternalStorage.request();
    }
    PermissionStatus status2 = await Permission.storage.status;
    if (!status2.isGranted) {
      await Permission.storage.request();
    }
    final dbPath = await getDatabasesPath();
    try {
      File dbFile = File('/storage/emulated/0/storemate/$dbName');
      await dbFile.copy('$dbPath/$dbName');
    } catch (e) {
      debugPrint('Error: $e');
    }
  }
}
