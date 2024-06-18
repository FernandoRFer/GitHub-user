import 'package:open_labs/view/home/home_module.dart';
import 'package:open_labs/view/search/saerch_module.dart';
import 'package:open_labs/view/splash/splash_module.dart';

class ViewModule {
  void configure() {
    SplashModule().configure();
    HomeModule().configure();
    SearchModule().configure();
  }
}
