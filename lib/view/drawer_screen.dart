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
  String _selectedLanguage = 'English';
  final SharedPreferenceClass sharedPreferenceClass = SharedPreferenceClass();
  final AppTextStyle appTextStyle = AppTextStyle();
  RxBool isAdmin = false.obs;

  @override
  void initState() {
    getIfAdmin();
    super.initState();
  }

  getIfAdmin() async {
    isAdmin.value = await sharedPreferenceClass.retrieveData(StringUtils.prefIsAdmin);
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
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          DrawerTile(
              title: 'Home',
              onTap: () {
                Get.back();
              }),
          DrawerTile(
            title: 'Language',
            // image: ImagePath.myAgent,
            onTap: () {
              Get.back();
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Select Language'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        RadioListTile<String>(
                          title: const Text('English'),
                          value: 'English',
                          activeColor: AppColors.scaffoldColor,
                          groupValue: _selectedLanguage,
                          onChanged: (value) {
                            // setState(() {
                            _selectedLanguage = value!;
                            // });
                          },
                        ),
                        RadioListTile<String>(
                          title: const Text('Gujarati'),
                          value: 'Gujarati',
                          groupValue: _selectedLanguage,
                          activeColor: AppColors.scaffoldColor,
                          onChanged: (value) {
                            // setState(() {
                            _selectedLanguage = value!;
                            // });
                          },
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                        },
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          // Perform language change here with _selectedLanguage
                          Navigator.of(context).pop(); // Close the dialog
                        },
                        child: const Text('Done'),
                      ),
                    ],
                  );
                },
              );
              // Get.to(() => const MyAgentScreen());
            },
          ),
          DrawerTile(title: 'Refer a friend', onTap: () {}),
          // isAdmin.value
          //     ?
          Column(
            children: [
              DrawerTile(
                  title: 'Upload PDF',
                  onTap: () {
                    Get.back();
                    Get.to(() => UploadPDF());
                  }),
              DrawerTile(
                  title: 'User Data List',
                  onTap: () {
                    Get.back();
                    Get.to(() => const UserDataWidget());
                  }),
            ],
          ),
          // : SizedBox(),
          DrawerTile(title: 'Rate Us', onTap: () {}),
          DrawerTile(
            title: 'Sign Out',
            // image: ImagePath.signOut,
            onTap: () async {
              // SharedPreferenceClass().removeData(StringUtils.userTokenKey);

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
  // final String image;
  // final AppTextStyle appTextStyle = AppTextStyle();
  final bool isLast;
  DrawerTile({super.key, required this.title, required this.onTap, this.isLast = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: ListTile(
        // leading: Image.asset(
        //   image,
        //   height: 22,
        //   width: 22,
        // ),
        title: Text(title),
        onTap: onTap,
        shape: Border(
          bottom: BorderSide(color: AppColors.lightBorderColor, width: 1.5),
        ),
      ),
    );
  }
}
