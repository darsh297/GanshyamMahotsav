import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ghanshyam_mahotsav/controller/malajap_controller.dart';
import 'package:ghanshyam_mahotsav/utils/app_text_styles.dart';
import 'package:ghanshyam_mahotsav/utils/shared_preference.dart';
import 'package:ghanshyam_mahotsav/utils/string_utils.dart';
import 'package:ghanshyam_mahotsav/view/mala_jap_screen.dart';
import 'package:ghanshyam_mahotsav/view/vanchan_screen.dart';

import '../controller/vanchan_screen_controller.dart';
import '../utils/app_colors.dart';
import 'profile_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final SharedPreferenceClass sharedPreferenceClass = SharedPreferenceClass();
  final RxInt _value = 0.obs;
  final RxString userName = ''.obs;
  final VanchanScreenController vanchanScreenController = Get.put(VanchanScreenController());
  final MalaJapController malaJapController = Get.put(MalaJapController());
  final AppTextStyle appTextStyle = AppTextStyle();
  final RxInt _selectedIndex = 0.obs;
  final RxInt creditScore = 0.obs;
  final List language = ['All', 'English', 'Gujarati'];

  @override
  void initState() {
    getUserName();
    super.initState();
  }

  getUserName() async {
    userName.value = await sharedPreferenceClass.retrieveData(StringUtils.prefUserName);
    creditScore.value = await sharedPreferenceClass.retrieveData(StringUtils.prefUserCredit);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: Get.width,
              color: AppColors.scaffoldColor,
              height: 150,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Welcome'.tr,
                    style: appTextStyle.inter20Grey,
                  ),
                  Obx(
                    () => Column(
                      children: [
                        Text(
                          '$userName',
                          style: appTextStyle.inter20DarkGrey,
                        ),
                        const SizedBox(height: 24),
                        Text(
                          '${'Credit Score:'.tr}:${creditScore.value}',
                          style: appTextStyle.inter12DarkGrey,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // SizedBox(height: 3),

            Stack(
              children: [
                ClipPath(
                  clipper: WaveClipper(),
                  child: Container(
                    height: 60,
                    color: AppColors.scaffoldColor,
                  ),
                ),
                Obx(
                  () {
                    if (_selectedIndex.value == 0) {
                      return Container(
                        padding: const EdgeInsets.only(right: 20),
                        width: Get.width,
                        child: Wrap(
                          spacing: 10,
                          alignment: WrapAlignment.end,
                          children: List.generate(
                            3,
                            (int index) {
                              // choice chip allow us to
                              // set its properties.
                              return ChoiceChip(
                                padding: const EdgeInsets.all(8),
                                label: Text('${language[index]}'.tr),
                                selectedColor: AppColors.primaryColor,
                                selected: _value.value == index,
                                onSelected: (bool selected) {
                                  (index != 0)
                                      ? vanchanScreenController.getAllPDF(queryParam: '?language=${language[index]}')
                                      : vanchanScreenController.getAllPDF();

                                  _value.value = (selected ? index : null)!;
                                },
                              );
                            },
                          ).toList(),
                        ),
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                )
              ],
            ),
            Obx(
              () => _selectedIndex.value == 0
                  ? const VanchanScreen()
                  : _selectedIndex.value == 1
                      ? const MalaJapScreen()
                      : const ProfileScreen(),
            )
          ],
        ),
      ),
      bottomNavigationBar: Obx(
        () => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: ClipPath(
            clipper: ShapeBorderClipper(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
            child: Container(
              color: AppColors.primaryColor,
              child: BottomNavigationBar(
                landscapeLayout: BottomNavigationBarLandscapeLayout.linear,
                type: BottomNavigationBarType.shifting,
                currentIndex: _selectedIndex.value,
                iconSize: 40,
                onTap: (value) {
                  if (value == 0) {
                    _value.value = 0;
                  } else if (value == 1) {
                    malaJapController.progress.value = 0;
                    malaJapController.dots.assignAll(List.generate(108, (_) => false));
                  }
                  _selectedIndex.value = value;
                },
                elevation: 5,
                items: [
                  BottomNavigationBarItem(
                    backgroundColor: AppColors.scaffoldColor,
                    icon: Image.asset(
                      StringUtils.reading,
                      height: 30,
                      width: 30,
                    ),
                    label: 'Vanchan'.tr,
                  ),
                  BottomNavigationBarItem(
                    icon: Image.asset(
                      StringUtils.malaJap,
                      height: 30,
                      width: 30,
                    ),
                    label: 'Mala Jap'.tr,
                  ),
                  BottomNavigationBarItem(
                    icon: Image.asset(
                      StringUtils.profile,
                      height: 30,
                      width: 30,
                    ),
                    label: 'Profile'.tr,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, 60); // manage straight line
    path.quadraticBezierTo(size.width / 12, 20, size.width / 4, 20);
    path.quadraticBezierTo(size.width, 20, size.width, 20);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
