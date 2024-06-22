import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:open_labs/core/helpers/global_error.dart';
import 'package:open_labs/core/navigator_app.dart';
import 'package:open_labs/repository/local_data_storage/search_history_db.dart.dart';
import 'package:open_labs/repository/user_repository/iuser_repository.dart';
import 'package:open_labs/repository/user_repository/user_repository.dart';
import 'package:open_labs/view/home/home_bloc.dart';

class MockGlobalError extends Mock implements IGlobalError {}

class MockNavigator extends Mock implements INavigatorApp {}

class MockUserRepository extends Mock implements IUserRepository {}

class MockDbHistory extends Mock implements IDbHistory {}

@GenerateMocks([MockGlobalError, UserRepository, MockDbHistory])
main() async {
  var nanigatorApp = MockNavigator();
  var globalError = MockGlobalError();
  var dbHistory = MockDbHistory();
  var userRepository = MockUserRepository();
  late HomeBloc homeBloc;
  group("Test dispose | ", () {
    setUp(() {});

    test("When calls dispose the stream gets close", () async {
      homeBloc = HomeBloc(
        globalError,
        nanigatorApp,
        userRepository,
        dbHistory,
      );
      var finalized = false;

      homeBloc.onFetchingData.listen((event) {}).onDone(() {
        finalized = true;
      });

      await homeBloc.dispose();
      await expectLater(finalized, isTrue);
    });

    (test("user not found", () async {
      when(userRepository.getUsers("notfound"))
          .thenAnswer((_) => throw Exception("Teste"));
      var example = HomeBloc(
        globalError,
        nanigatorApp,
        userRepository,
        dbHistory,
      );
      await example.getUserName("notfound");
    }));
  });
}
