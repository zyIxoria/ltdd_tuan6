import 'package:ltdd_tuan6/model/sinhvien.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'app_qlsv.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE sinhviens(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            email TEXT UNIQUE NOT NULL
          )
        ''');
      },
    );
  }

  // =========================
  // THÊM SINH VIÊN
  // =========================
  Future<int> insertSinhVien(SinhVien stu) async {
    final db = await database;
    return await db.insert(
      'sinhviens',
      stu.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // =========================
  // LẤY DANH SÁCH SINH VIÊN
  // =========================
  Future<List<SinhVien>> getSinhViens() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'sinhviens',
      orderBy: 'id ASC',
    );

    return List.generate(maps.length, (i) {
      return SinhVien(
        id: maps[i]['id'],
        name: maps[i]['name'],
        email: maps[i]['email'],
      );
    });
  }

  // =========================
  // CẬP NHẬT SINH VIÊN
  // =========================
  Future<int> updateSinhVien(SinhVien stu) async {
    final db = await database;
    return await db.update(
      'sinhviens',
      stu.toMap(),
      where: "id = ?",
      whereArgs: [stu.id],
    );
  }

  // =========================
  // XÓA 1 SINH VIÊN
  // Nếu xóa xong bảng rỗng -> reset AUTOINCREMENT về 0
  // để lần thêm tiếp theo id sẽ bắt đầu lại từ 1
  // =========================
  Future<int> deleteSinhVien(int id) async {
    final db = await database;

    int result = await db.delete(
      'sinhviens',
      where: "id = ?",
      whereArgs: [id],
    );

    // Kiểm tra còn sinh viên nào không
    final countResult = await db.rawQuery('SELECT COUNT(*) as count FROM sinhviens');
    int count = Sqflite.firstIntValue(countResult) ?? 0;

    // Nếu bảng rỗng -> reset lại AUTOINCREMENT
    if (count == 0) {
      await db.rawDelete("DELETE FROM sqlite_sequence WHERE name = 'sinhviens'");
    }

    return result;
  }

  // =========================
  // XÓA TOÀN BỘ SINH VIÊN (nếu cần)
  // =========================
  Future<void> deleteAllSinhViens() async {
    final db = await database;
    await db.delete('sinhviens');

    // reset lại auto increment
    await db.rawDelete("DELETE FROM sqlite_sequence WHERE name = 'sinhviens'");
  }
}