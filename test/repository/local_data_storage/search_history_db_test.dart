import 'package:flutter_test/flutter_test.dart';
import 'package:open_labs/repository/local_data_storage/search_history_db.dart.dart';
import 'package:open_labs/repository/local_data_storage/search_history_model.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

const String kTemporaryPath = 'temporaryPath';
const String kApplicationSupportPath = 'applicationSupportPath';
const String kDownloadsPath = 'downloadsPath';
const String kLibraryPath = 'libraryPath';
const String kApplicationDocumentsPath = 'applicationDocumentsPath';
const String kExternalCachePath = 'externalCachePath';
const String kExternalStoragePath = 'externalStoragePath';

void sqfliteTestInit() {
  // Initialize ffi implementation
  sqfliteFfiInit();
  // Set global factory
  databaseFactory = databaseFactoryFfi;
}

Future main() async {
  late DbHistory dbHistory;
  sqfliteTestInit();

  PathProviderPlatform.instance = FakePathProviderPlatform();

  group("test table", () {
    setUp(() async {
      dbHistory = DbHistory();
      await dbHistory.insert(SearchHistoryModel(
          searchWord: "Fernando",
          dateTime: DateTime.now().microsecondsSinceEpoch));
      await dbHistory.insert(SearchHistoryModel(
          searchWord: "Felipe",
          dateTime: DateTime.now().microsecondsSinceEpoch));
    });
    test("clean table", () async {
      final historyList = await dbHistory.get();
      for (var i = 0; i < historyList.length; i++) {
        await dbHistory.remove(historyList[i].id!);
      }
    });
    test("recording confirmation", () async {
      final historyList = await dbHistory.get();

      expect(historyList[0].searchWord, 'Felipe');
      expect(historyList[1].searchWord, 'Fernando');
    });

    test("clean table", () async {
      final historyList = await dbHistory.get();
      for (var i = 0; i < historyList.length; i++) {
        await dbHistory.remove(historyList[i].id!);
      }
    });

    test("remove item", () async {
      final historyList = await dbHistory.get();
      await dbHistory.remove(historyList[0].id!);

      final result = await dbHistory.get();

      expect(result.length, 1);
    });
  });
}

class FakePathProviderPlatform extends Fake
    with MockPlatformInterfaceMixin
    implements PathProviderPlatform {
  @override
  Future<String?> getTemporaryPath() async {
    return kTemporaryPath;
  }

  @override
  Future<String?> getApplicationSupportPath() async {
    return kApplicationSupportPath;
  }

  @override
  Future<String?> getLibraryPath() async {
    return kLibraryPath;
  }

  @override
  Future<String?> getApplicationDocumentsPath() async {
    return kApplicationDocumentsPath;
  }

  @override
  Future<String?> getExternalStoragePath() async {
    return kExternalStoragePath;
  }

  @override
  Future<List<String>?> getExternalCachePaths() async {
    return <String>[kExternalCachePath];
  }

  @override
  Future<List<String>?> getExternalStoragePaths({
    StorageDirectory? type,
  }) async {
    return <String>[kExternalStoragePath];
  }

  @override
  Future<String?> getDownloadsPath() async {
    return kDownloadsPath;
  }
}
