import 'package:get/get.dart';

class HomeController extends GetxController {
  final RxInt creditScore = 0.obs;
  final RxInt selectedLanguageIndex = 0.obs;
  final RxList language = ['All', 'English', 'Gujarati'].obs;
}
