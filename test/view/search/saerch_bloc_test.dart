import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:github_user/core/helpers/global_error.dart';
import 'package:github_user/core/navigator_app.dart';
import 'package:github_user/repository/local_db/search_history_db.dart.dart';
import 'package:github_user/view/search/saerch_bloc.dart';

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
