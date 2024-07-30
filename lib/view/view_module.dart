import 'package:github_user/view/auth/auth_module.dart';
import 'package:github_user/view/home/home_module.dart';
import 'package:github_user/view/search/saerch_module.dart';
import 'package:github_user/view/splash/splash_module.dart';

class ViewModule {
  void configure() {
    SplashModule().configure();
    HomeModule().configure();
    SearchModule().configure();
    AuthModule().configure();
  }
}
