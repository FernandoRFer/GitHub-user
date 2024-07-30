import 'package:github_user/repository/model/logged_user_model.dart';
import 'package:github_user/repository/model/user_repos_model.dart';

abstract class IGithubRepository {
  Future<LoggedUserModel?> getUser(String user);
  Future<LoggedUserModel?> getLoggedUser();
  Future<List<UserReposModel?>> repos();
}
