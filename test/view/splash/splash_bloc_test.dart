import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:open_labs/core/helpers/global_error.dart';
import 'package:open_labs/core/navigator_app.dart';
import 'package:open_labs/view/splash/splash_bloc.dart';

class MockGlobalError extends Mock implements IGlobalError {}

class MockNavigator extends Mock implements INavigatorApp {}

main() async {
  var nanigatorApp = MockNavigator();
  var globalError = MockGlobalError();

  group("Test dispose | ", () {
    test("When calls dispose the stream gets close", () async {
      var example = SplashBloc(
        nanigatorApp,
        globalError,
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
