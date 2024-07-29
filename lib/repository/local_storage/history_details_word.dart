import 'dart:convert';
import 'dart:async';

import 'package:open_labs/repository/local_storage/storage_cache.dart';
import 'package:open_labs/repository/model/search_history_model.dart';

abstract class IHistoryCache {
  Future<SearchHistoryModel?> get(String id);
  Future<void> put(SearchHistoryModel data);
}

class HistoryCache implements IHistoryCache {
  final IStorageCache _storageCache;

  HistoryCache(this._storageCache);

  @override
  Future<SearchHistoryModel?> get(String id) async {
    final data = await _storageCache.get(id);

    if (data == null) return null;
    var convertStrint = (jsonEncode(data));

    return SearchHistoryModel.fromJson(jsonDecode(convertStrint));
  }

  @override
  Future<void> put(SearchHistoryModel data) async {
    await _storageCache.put("SearchHistoryModel", jsonEncode(data.toJson()));
  }
  // final completer = Completer<Box>();

  // HistoryCache() {
  //   _initDb();
  // }
  // Future _initDb() async {
  //   var appDocDirectory = await getApplicationDocumentsDirectory();
  //   Hive.init(appDocDirectory.path);
  //   // ..registerAdapter(CacheModelAdapter());

  //   final box = await Hive.openBox('HistoryDetailsWord');
  //   if (!completer.isCompleted) completer.complete(box);
  // }

  // @override
  // Future<void> put(SearchHistoryModel data) async {
  //   final box = await completer.future;
  //   await box.put(data.word, data.toJson());
  // }

  // @override
  // Future<SearchHistoryModel?> get(String id) async {
  //   final box = await completer.future;
  //   final data = await box.get(id);

  //   if (data == null) return null;
  //   var convertStrint = (jsonEncode(data));

  //   return SearchHistoryModel.fromJson(jsonDecode(convertStrint));
  // }
}
