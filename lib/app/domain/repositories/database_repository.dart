abstract class DatabaseRepository {
  Future<int> insertInto({
    required String table,
    required Map<String, dynamic> row,
  });
  Future<List<Map<String, Object?>>>? getAllFrom({
    required String table,
    String? where,
    List<Object>? whereArgs,
    String? orderBy,
    int? limit,
  });
  Future<List<Map<String, Object?>>>? getFrom({
    required String table,
    String? where,
    List<Object>? whereArgs,
    String? orderBy,
    int? limit,
  });
  Future<int> update({
    required String table,
    required Map<String, dynamic> row,
    String? where,
    List<Object>? whereArgs,
  });
  Future<int> delete({
    required String table,
    String? where,
    List<Object>? whereArgs,
  });
  Future<void> backupDB();
  Future<void> restoreDB();
}
