import 'package:open_labs/repository/local_data_storage/search_history_model.dart';
import 'package:path/path.dart' as p;
import 'dart:io' as io;
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path_provider/path_provider.dart';

abstract class IDbHistory {
  Future<int> insert(SearchHistoryModel searHistoryModel);
  Future<List<SearchHistoryModel>> get();
  Future<int> remove(int id);
}

class DbHistory implements IDbHistory {
  final String _tableName = "searchHistory";
  final String _id = "id";
  final String _searchWord = "searchWord";
  final String _dateTime = "dateTime";

  Database? _db;

  // static final DbHistory instance = DbHistory._();
  // factory DbHistory() {
  //   return instance;
  // }
  // DbHistory._();

  get db async {
    _db ??= await starDB();
    return _db;
  }

  Future<void> _onCreate(Database db, int version) async {
    String sql =
        "CREATE TABLE $_tableName ($_id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, $_dateTime INTEGER ,$_searchWord TEXT)";
    await db.execute(sql);
  }

  Future<Database> starDB() async {
    // sqfliteFfiInit();
    // var databaseFactory = databaseFactoryFfi;

    final io.Directory appDocumentsDir =
        await getApplicationDocumentsDirectory();

    if (!await appDocumentsDir.exists()) {
      appDocumentsDir.create(recursive: true);
    }

    String dbPath = p.join(appDocumentsDir.path, "produtos.db");

    Database db = await databaseFactory.openDatabase(dbPath,
        options: OpenDatabaseOptions(version: 1, onCreate: _onCreate));

    return db;
  }

  @override
  Future<int> insert(SearchHistoryModel searHistory) async {
    Database bancoDados = await db;
    final json = searHistory.toJson();

    int resultado = await bancoDados.insert(_tableName, json);
    return resultado;
  }

  @override
  Future<List<SearchHistoryModel>> get() async {
    Database bancoDados = await db;
    final result = await bancoDados
        .rawQuery("SELECT * FROM $_tableName ORDER BY $_dateTime DESC");

    return result.map((e) => SearchHistoryModel.fromJson(e)).toList();
  }

  @override
  Future<int> remove(int id) async {
    Database bancoDados = await db;
    return await bancoDados
        .delete(_tableName, where: "id = ?", whereArgs: [id]);
  }
}
