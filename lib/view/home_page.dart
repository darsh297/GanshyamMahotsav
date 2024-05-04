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
      // key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      // drawer: const DrawerScreen(),
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
                  // Align(
                  //   alignment: Alignment.topLeft,
                  //   child: IconButton(
                  //     onPressed: () => _scaffoldKey.currentState?.openDrawer(),
                  //     icon: const Icon(Icons.menu),
                  //     padding: EdgeInsets.zero,
                  //   ),
                  // ),
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
                          'Credit Score: ${creditScore.value}'.tr,
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
        () => BottomNavigationBar(
          selectedItemColor: AppColors.primaryColor,
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
    );

    // return Scaffold(
    //   key: _scaffoldKey,
    //   resizeToAvoidBottomInset: false,
    //   backgroundColor: AppColors.scaffoldColor,
    //   appBar: AppBar(
    //     backgroundColor: Colors.transparent,
    //     leading: IconButton(
    //       icon: const Icon(Icons.menu),
    //       onPressed: () => _scaffoldKey.currentState?.openDrawer(),
    //     ),
    //   ),
    //   drawer: const DrawerScreen(),
    //   body: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //     children: [
    //       Container(
    //         height: MediaQuery.of(context).size.height * 0.11,
    //         padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 18),
    //         child: Obx(() => Text(userName.value != '' ? 'Welcome,${userName.value}!'.tr : 'Welcome'.tr, style: appTextStyle.montserrat22W700White)),
    //       ),
    //       Expanded(child: Obx(() => isPDFView.value ? const VanchanScreen() : const MalaJapScreen())),
    //       InkWell(
    //         onTap: () => isPDFView.value = !isPDFView.value,
    //         child: Container(
    //           height: MediaQuery.of(context).size.height * 0.05,
    //           width: Get.width,
    //           alignment: Alignment.center,
    //           padding: const EdgeInsets.all(8),
    //           margin: const EdgeInsets.all(8),
    //           decoration: BoxDecoration(color: AppColors.primaryColor, borderRadius: BorderRadius.circular(10)),
    //           child: Obx(
    //             () => Text(
    //               isPDFView.value ? 'Go to Malajap'.tr : 'Go to Vanchan'.tr,
    //               style: appTextStyle.montserrat14W500White,
    //             ),
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
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
