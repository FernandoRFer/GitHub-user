import 'package:open_labs/repository/user_repository/model/user_model.dart';

abstract class IUserRepository {
  Future<UserModel?> getUsers(String user);
}
