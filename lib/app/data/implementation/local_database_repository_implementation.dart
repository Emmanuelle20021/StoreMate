import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sqflite/sqflite.dart';
import 'package:store_mate/app/domain/repositories/database_repository.dart';
import 'package:path/path.dart' as p;

class LocalDatatabaseImplementation implements DatabaseRepository {
  final String _productsTable = 'Product';
  final String _salesTable = 'Sale';
  final String _salesDetailsTable = 'Sale_Detail';
  final String _dbName = 'storemate.db';
  final String _backupDirectoryPath = '/storage/emulated/0/storemate/';

  LocalDatatabaseImplementation() {
    _initDB(_dbName);
  }

  Database? _database;

  Future<Database?> get database async {
    _database = await _initDB(_dbName);
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
      singleInstance: true,
    );
  }

  static Future _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  Future<void> _onCreateDB(Database db, int version) async {
    await db.execute(
      '''CREATE TABLE `$_productsTable` (
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
      ON `$_productsTable` (`product_name`);''',
    );
    await db.execute(
      '''CREATE INDEX `Product_index_category`
      ON `$_productsTable` (`product_category`);''',
    );
    await db.execute(
      '''CREATE TABLE `$_salesTable` (
	    `sale_id` INTEGER NOT NULL UNIQUE,
	    `sale_creation_date` TEXT NOT NULL,
	    `sale_total_amount` REAL NOT NULL,
	    `sale_enable` INTEGER DEFAULT 1,
	    PRIMARY KEY(`sale_id`)
      );''',
    );
    await db.execute(
      '''CREATE INDEX `Sale_index_date`
      ON `$_salesTable` (`sale_creation_date`);''',
    );

    await db.execute(
      '''CREATE TABLE `$_salesDetailsTable` (
	    `detail_id` INTEGER NOT NULL  UNIQUE,
	    `product_id` INTEGER NOT NULL,
	    `sale_id` INTEGER NOT NULL,
	    `detail_quantity` INTEGER NOT NULL,
	    PRIMARY KEY(`detail_id`),
      FOREIGN KEY(`product_id`) REFERENCES `$_productsTable`(`product_id`)
      ON UPDATE NO ACTION ON DELETE NO ACTION,
      FOREIGN KEY(`sale_id`) REFERENCES `$_salesTable`(`sale_id`)
      ON UPDATE NO ACTION ON DELETE NO ACTION
      );''',
    );
  }

  @override
  Future<void> backupDB() async {
    PermissionStatus externalStoregeStatus =
        await Permission.manageExternalStorage.status;
    if (!externalStoregeStatus.isGranted) {
      await Permission.manageExternalStorage.request();
    }
    PermissionStatus storegeStatus = await Permission.storage.status;
    if (!storegeStatus.isGranted) {
      await Permission.storage.request();
    }
    final dbPath = await getDatabasesPath();
    try {
      File dbFile = File('$dbPath/$_dbName');
      Directory? backubDirectory = Directory(_backupDirectoryPath);
      await backubDirectory.create();
      await dbFile.copy('${backubDirectory.path}/$_dbName');
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  @override
  Future<int> delete({
    required String table,
    String? where,
    List<Object>? whereArgs,
  }) async {
    final Database? db = await database;
    if (db != null && db.isOpen) {
      return db.delete(
        table,
        where: where,
        whereArgs: whereArgs,
      );
    } else {
      return Future.error('Database not open');
    }
  }

  @override
  Future<List<Map<String, Object?>>> getAllFrom({
    required String table,
    String? where,
    List<Object>? whereArgs,
    String? orderBy,
    int? limit,
  }) async {
    final Database? db = await database;

    if (db != null && db.isOpen) {
      return db.query(
        table,
        orderBy: orderBy,
        limit: limit,
        where: where,
        whereArgs: whereArgs,
      );
    } else {
      return Future.error('Database not open');
    }
  }

  @override
  Future<List<Map<String, Object?>>> getFrom({
    required String table,
    String? where,
    List<Object>? whereArgs,
    String? orderBy,
    int? limit = 1,
  }) async {
    final Database? db = await database;
    if (db != null && db.isOpen) {
      return db.query(
        table,
        orderBy: orderBy,
        limit: limit,
        where: where,
        whereArgs: whereArgs,
      );
    } else {
      return Future.error('Database not open');
    }
  }

  @override
  Future<int> insertInto({
    required String table,
    required Map<String, dynamic> row,
  }) async {
    try {
      final Database? db = await database;
      if (db != null && db.isOpen) {
        return db.insert(
          table,
          row,
        );
      } else {
        return Future.value(0);
      }
    } catch (e) {
      return Future.error('error: $e');
    }
  }

  @override
  Future<void> restoreDB() async {
    PermissionStatus externalStorageStatus =
        await Permission.manageExternalStorage.status;
    if (!externalStorageStatus.isGranted) {
      await Permission.manageExternalStorage.request();
    }
    PermissionStatus storegeStatus = await Permission.storage.status;
    if (!storegeStatus.isGranted) {
      await Permission.storage.request();
    }
    final dbPath = await getDatabasesPath();
    try {
      File dbFile = File('$_backupDirectoryPath/$_dbName');
      await dbFile.copy('$dbPath/$_dbName');
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  @override
  Future<int> update({
    required String table,
    required Map<String, dynamic> row,
    String? where,
    List<Object>? whereArgs,
  }) async {
    final Database? db = await database;
    if (db != null && db.isOpen) {
      return db.update(table, row, where: where, whereArgs: whereArgs);
    } else {
      return Future.value(0);
    }
  }
}
