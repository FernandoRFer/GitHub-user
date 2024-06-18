import 'package:open_labs/repository/local_data_storage/search_history_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

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

  static final DbHistory _dbMusica = DbHistory._();
  factory DbHistory() {
    return _dbMusica;
  }
  DbHistory._();

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
    final caminhoBancoDados = await getDatabasesPath();
    final localBancoDados = join(caminhoBancoDados, "produtos.db");

    Database db =
        await openDatabase(localBancoDados, version: 1, onCreate: _onCreate);

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
    var bancoDados = await db;
    return await bancoDados
        .delete(_tableName, where: "id = ?", whereArgs: [id]);
  }
}
