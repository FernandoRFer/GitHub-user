import 'dart:convert';
import 'package:hive/hive.dart';
import 'dart:async';

import 'package:path_provider/path_provider.dart';

abstract class IStorageCache {
  Future<String?> get(String id);
  Future<void> put(String key, String value);
}

class HiveStorage implements IStorageCache {
  final completer = Completer<Box>();

  HiveStorage() {
    _initDb();
  }
  Future _initDb() async {
    var appDocDirectory = await getApplicationDocumentsDirectory();
    Hive.init(appDocDirectory.path);

    final box = await Hive.openBox('WordeExplorer');
    if (!completer.isCompleted) completer.complete(box);
  }

  //refatora para aceitar lista add e remove
  @override
  Future<void> put(String key, String value) async {
    final box = await completer.future;

    await box.put(key, value);
  }

  @override
  Future<String?> get(String id) async {
    final box = await completer.future;
    final data = await box.get(id);

    if (data == null) return null;
    return data;
  }
}
