import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ghanshyam_mahotsav/model/global_response.dart';
import 'package:ghanshyam_mahotsav/network/api_config.dart';
import 'package:ghanshyam_mahotsav/network/api_strings.dart';
import 'package:ghanshyam_mahotsav/utils/shared_preference.dart';
import 'package:ghanshyam_mahotsav/utils/string_utils.dart';
import 'package:ghanshyam_mahotsav/view/home_page.dart';
import 'package:ghanshyam_mahotsav/view/login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final Rx<Locale> initLang = const Locale('en', 'US').obs;
  final SharedPreferenceClass sharedPreferenceClass = SharedPreferenceClass();
  final RxString _selectedLanguage = StringUtils.english.obs;
  final ApiBaseHelper apiBaseHelper = ApiBaseHelper();
  getIfAdmin() async {
    _selectedLanguage.value = await sharedPreferenceClass.retrieveData(StringUtils.prefLanguage) ?? StringUtils.english;
    debugPrint('|||||||||||||||||||||||||||||||||||||||||||||||||||||||| $_selectedLanguage');
    if (_selectedLanguage.value != StringUtils.english) {
      Get.updateLocale(const Locale('hi', 'IN'));
    }
  }

  checkLogin(context) async {
    String? token = await sharedPreferenceClass.retrieveData(StringUtils.prefUserTokenKey);
    debugPrint('Token Splesh screen $token');
    Future.delayed(
      const Duration(seconds: 1),
      () async {
        if (token == null) {
          Get.offAll(() => LoginPage());
        } else {
          var api = await apiBaseHelper.getData(leadAPI: ApiStrings.kGetCredits);
          GlobalResponse globalResponse = GlobalResponse.fromJson(api);
          if (globalResponse.status == 200) {
            sharedPreferenceClass.storeData(StringUtils.prefUserCredit, globalResponse.data['count']);
          }
          Get.offAll(() => const HomePage());
        }
      },
    );
  }

  @override
  void initState() {
    getIfAdmin();
    checkLogin(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Hero(
            tag: 'logo',
            child: Material(
              type: MaterialType.transparency,
              child: Image.asset(StringUtils.logo),
            ),
          ),
        ),
      ),
    );
  }
}
