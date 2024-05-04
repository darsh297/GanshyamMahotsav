import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ghanshyam_mahotsav/view/login_page.dart';

import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import '../utils/shared_preference.dart';
import '../utils/string_utils.dart';
import 'upload_pdf.dart';
import 'user_data_list.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final RxString _selectedLanguage = StringUtils.english.obs;
  final SharedPreferenceClass sharedPreferenceClass = SharedPreferenceClass();
  final AppTextStyle appTextStyle = AppTextStyle();
  final RxInt credits = 0.obs;
  final RxBool isAdmin = false.obs;

  getIfAdmin() async {
    isAdmin.value = await sharedPreferenceClass.retrieveData(StringUtils.prefIsAdmin);
    credits.value = await sharedPreferenceClass.retrieveData(StringUtils.prefUserCredit);
    _selectedLanguage.value = await sharedPreferenceClass.retrieveData(StringUtils.prefLanguage) ?? 'English';
    debugPrint('object $_selectedLanguage|| isAdmin.value ${isAdmin.value}');
  }

  @override
  void initState() {
    getIfAdmin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DrawerTile(
          title: 'Language',
          icons: const Icon(Icons.language),
          // image: ImagePath.myAgent,
          onTap: () {
            Get.back();
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Select Language'),
                  content: Obx(
                    () => Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        RadioListTile<String>(
                          title: const Text('English'),
                          value: StringUtils.english,
                          activeColor: AppColors.scaffoldColor,
                          groupValue: _selectedLanguage.value,
                          onChanged: (value) => _selectedLanguage.value = value!,
                        ),
                        RadioListTile<String>(
                          title: const Text('ગુજરાતી'),
                          value: 'Gujarati',
                          groupValue: _selectedLanguage.value,
                          activeColor: AppColors.scaffoldColor,
                          onChanged: (value) => _selectedLanguage.value = value!,
                        ),
                      ],
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Get.back(),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        _selectedLanguage.value == 'English' ? Get.updateLocale(const Locale('en', 'US')) : Get.updateLocale(const Locale('hi', 'IN'));
                        sharedPreferenceClass.storeData(StringUtils.prefLanguage, _selectedLanguage.value);
                        Get.back(); // Close the dialog
                      },
                      child: const Text('Done'),
                    ),
                  ],
                );
              },
            );
          },
        ),
        Obx(
          () => isAdmin.value
              ? Column(
                  children: [
                    DrawerTile(
                        title: 'Upload PDF',
                        icons: const Icon(Icons.picture_as_pdf),
                        onTap: () {
                          Get.back();
                          Get.to(() => UploadPDF());
                        }),
                    DrawerTile(
                        title: 'User Data List',
                        icons: const Icon(Icons.person),
                        onTap: () {
                          Get.back();
                          Get.to(() => const UserDataWidget());
                        }),
                  ],
                )
              : const SizedBox(),
        ),
        DrawerTile(
          title: 'Refer a friend',
          onTap: () {},
          icons: const Icon(Icons.front_hand_outlined),
        ),
        DrawerTile(title: 'Rate Us', onTap: () {}, icons: const Icon(Icons.star_rate)),
        DrawerTile(
          title: 'Sign Out',
          icons: const Icon(Icons.login_outlined),
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Sign Out'),
                  content: const Text('Are you sure you want to sign out?'),
                  actions: [
                    TextButton(
                      onPressed: () => Get.back(),
                      child: const Text('No'),
                    ),
                    TextButton(
                      onPressed: () {
                        SharedPreferenceClass().removeAllData();
                        Get.offAll(() => LoginPage());
                      },
                      child: const Text('Yes'),
                    ),
                  ],
                );
              },
            );
          },
          isLast: true,
        ),
      ],
    );
  }
}

class DrawerTile extends StatelessWidget {
  final String title;
  final Function() onTap;
  final bool isLast;
  final Widget icons;
  const DrawerTile({super.key, required this.title, required this.onTap, this.isLast = false, required this.icons});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: ListTile(
        title: Text(title.tr),
        leading: icons,
        onTap: onTap,
        shape: Border(
          bottom: BorderSide(color: AppColors.lightBorderColor, width: 1.5),
        ),
      ),
    );
  }
}
