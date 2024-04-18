import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ghanshyam_mahotsav/view/login_page.dart';

import '../utils/app_colors.dart';

class DrawerScreen extends StatelessWidget {
  DrawerScreen({super.key});
  String _selectedLanguage = 'English';
  // final AppTextStyle appTextStyle = AppTextStyle();

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
                    padding: EdgeInsets.only(bottom: 40),
                  ),
                  // Container(
                  //   color: AppColors.scaffoldColor,
                  //   height: 50,
                  // ),
                ],
              ),
              // Positioned(
              //   top: 50,
              //   child: CircleAvatar(
              //     radius: 45,
              //     backgroundColor: AppColors.scaffoldColor.withOpacity(0.4),
              //     child: CircleAvatar(
              //       backgroundColor: AppColors.grey,
              //       radius: 40,
              //       // child: Image.asset(ImagePath.person, height: 35, width: 32),
              //     ),
              //   ),
              // )
            ],
          ),

          // Text('Tanya Hill '),

          ///Edit profile
          // TextButton(
          //   child: Text(
          //     'Edit Profile',
          //     // style: appTextStyle.montserrat14Grey,
          //   ),
          //   onPressed: () => Get.to(() => EditProfile()),
          // ),
          const SizedBox(height: 10),
          DrawerTile(
              title: 'Home',
              // image: ImagePath.dashboard,
              onTap: () {
                Get.back();
                // Get.to(() => const ChatScreen());
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
                    title: Text('Select Language'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        RadioListTile<String>(
                          title: Text('English'),
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
                          title: Text('Hindi'),
                          value: 'Hindi',
                          groupValue: _selectedLanguage,
                          activeColor: AppColors.scaffoldColor,
                          onChanged: (value) {
                            // setState(() {
                            _selectedLanguage = value!;
                            // });
                          },
                        ),
                        RadioListTile<String>(
                          title: Text('Gujarati'),
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
                        child: Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          // Perform language change here with _selectedLanguage
                          Navigator.of(context).pop(); // Close the dialog
                        },
                        child: Text('Done'),
                      ),
                    ],
                  );
                },
              );
              // Get.to(() => const MyAgentScreen());
            },
          ),

          DrawerTile(title: 'Refer a friend', onTap: () {}),
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
