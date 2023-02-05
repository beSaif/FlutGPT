import 'package:get/get.dart';

class ThemeController extends GetxController {
  var isDarkMode = true.obs;

  void changeThemeMode() {
    isDarkMode.value = !isDarkMode.value;
  }
}
