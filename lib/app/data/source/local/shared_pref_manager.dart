import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefManager {
  late SharedPreferences preferences;
  SharedPrefManager() {
    init();
  }
  Future init() async => preferences = await SharedPreferences.getInstance();
}
