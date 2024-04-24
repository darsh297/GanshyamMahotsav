import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ghanshyam_mahotsav/view/user_data_list.dart';
import 'package:ghanshyam_mahotsav/view/login_page.dart';
import 'package:ghanshyam_mahotsav/view/upload_pdf.dart';

import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';
import '../utils/shared_preference.dart';
import '../utils/string_utils.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  final RxString _selectedLanguage = 'English'.obs;
  final SharedPreferenceClass sharedPreferenceClass = SharedPreferenceClass();
  final AppTextStyle appTextStyle = AppTextStyle();
  final RxBool isAdmin = false.obs;
  final RxInt credits = 0.obs;

  @override
  void initState() {
    getIfAdmin();
    getCredits();
    super.initState();
  }

  getIfAdmin() async {
    isAdmin.value = await sharedPreferenceClass.retrieveData(StringUtils.prefIsAdmin);
  }

  getCredits() async {
    credits.value = await SharedPreferenceClass().retrieveData(StringUtils.prefUserCredit);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Column(
                children: [
                  Container(
                    color: AppColors.primaryColor,
                    height: 100,
                    padding: const EdgeInsets.only(bottom: 40),
                  ),
                  Container(
                    height: 60,
                    width: double.infinity,
                    // margin: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                      color: AppColors.primaryColor,
                      border: Border.all(color: AppColors.white, width: 1),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.black.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 3,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Mahek Mehta',
                          style: appTextStyle.montserrat14W600White,
                        ),
                        Text(
                          'Credit Score : ${credits.value}',
                          style: appTextStyle.montserrat14W600White,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          DrawerTile(
              title: 'Home',
              icons: Icon(Icons.home),
              onTap: () {
                Get.back();
              }),
          DrawerTile(
            title: 'Language',
            icons: Icon(Icons.language),
            // image: ImagePath.myAgent,
            onTap: () {
              Get.back();
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Select Language'.tr),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        RadioListTile<String>(
                          title: Text('English'.tr),
                          value: 'English',
                          activeColor: AppColors.scaffoldColor,
                          groupValue: _selectedLanguage.value,
                          onChanged: (value) {
                            _selectedLanguage.value = value!;
                            Get.updateLocale(const Locale('en', 'US'));
                          },
                        ),
                        RadioListTile<String>(
                          title: Text('Gujarati'.tr),
                          value: 'Gujarati',
                          groupValue: _selectedLanguage.value,
                          activeColor: AppColors.scaffoldColor,
                          onChanged: (value) {
                            _selectedLanguage.value = value!;
                            Get.updateLocale(const Locale('hi', 'IN'));
                          },
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                        },
                        child: Text('Cancel'.tr),
                      ),
                      TextButton(
                        onPressed: () {
                          // Perform language change here with _selectedLanguage
                          Navigator.of(context).pop(); // Close the dialog
                        },
                        child: Text('Done'.tr),
                      ),
                    ],
                  );
                },
              );
              // Get.to(() => const MyAgentScreen());
            },
          ),
          DrawerTile(
            title: 'Refer a friend',
            onTap: () {},
            icons: Icon(Icons.front_hand_outlined),
          ),
          Obx(
            () => isAdmin.value
                ? Column(
                    children: [
                      DrawerTile(
                          title: 'Upload PDF',
                          icons: Icon(Icons.picture_as_pdf),
                          onTap: () {
                            Get.back();
                            Get.to(() => UploadPDF());
                          }),
                      DrawerTile(
                          title: 'User Data List',
                          icons: Icon(Icons.person),
                          onTap: () {
                            Get.back();
                            Get.to(() => const UserDataWidget());
                          }),
                    ],
                  )
                : const SizedBox(),
          ),
          DrawerTile(title: 'Rate Us', onTap: () {}, icons: Icon(Icons.star_rate)),
          DrawerTile(
            title: 'Sign Out',
            icons: Icon(Icons.login_outlined),
            // image: ImagePath.signOut,
            onTap: () async {
              SharedPreferenceClass().removeAllData();

              Get.offAll(() => LoginPage());
            },
            isLast: true,
          ),
        ],
      ),
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
