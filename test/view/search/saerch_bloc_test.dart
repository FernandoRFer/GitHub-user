import 'package:flutter_test/flutter_test.dart';

import 'package:mocktail/mocktail.dart';
import 'package:open_labs/core/helpers/global_error.dart';
import 'package:open_labs/core/navigator_app.dart';
import 'package:open_labs/repository/local_data_storage/search_history_db.dart.dart';
import 'package:open_labs/view/search/saerch_bloc.dart';

class MockGlobalError extends Mock implements IGlobalError {}

class MockNavigator extends Mock implements INavigatorApp {}

class MockDbHistory extends Mock implements IDbHistory {}

main() async {
  final nanigatorApp = MockNavigator();
  final globalError = MockGlobalError();
  final dbHistoryr = MockDbHistory();

  group("Test dispose | ", () {
    test("When calls dispose the stream gets close", () async {
      var example = SearchBloc(
        globalError,
        nanigatorApp,
        dbHistoryr,
      );

      var finalized = false;

      example.onFetchingData.listen((event) {}).onDone(() {
        finalized = true;
      });

      await example.dispose();
      await expectLater(finalized, isTrue);
    });
  });
}
