import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ghanshyam_mahotsav/utils/app_text_styles.dart';
import 'package:ghanshyam_mahotsav/utils/shared_preference.dart';
import 'package:ghanshyam_mahotsav/utils/string_utils.dart';
import 'package:ghanshyam_mahotsav/view/drawer_screen.dart';
import 'package:ghanshyam_mahotsav/view/mala_jap_screen.dart';
import 'package:ghanshyam_mahotsav/view/vanchan_screen.dart';
import '../controller/vanchan_screen_controller.dart';
import '../utils/app_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final VanchanScreenController vanchanScreenController = Get.put(VanchanScreenController());
  final SharedPreferenceClass sharedPreferenceClass = SharedPreferenceClass();
  final RxBool isListView = true.obs;
  final RxBool isPDFView = true.obs;
  final RxString userName = ''.obs;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final AppTextStyle appTextStyle = AppTextStyle();

  @override
  void initState() {
    getUserName();
    super.initState();
  }

  getUserName() async {
    userName.value = await sharedPreferenceClass.retrieveData(StringUtils.prefUserName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      drawer: const DrawerScreen(),
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
                  Align(
                      child: IconButton(onPressed: () => _scaffoldKey.currentState?.openDrawer(), icon: Icon(Icons.menu), padding: EdgeInsets.zero),
                      alignment: Alignment.topLeft),
                  Text(
                    'Welcome',
                    style: appTextStyle.inter20Grey,
                  ),
                  Text(
                    '$userName',
                    style: appTextStyle.inter20DarkGrey,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const SizedBox(width: 20),
                    ElevatedButton(onPressed: () {}, child: const Text('All')),
                    ElevatedButton(onPressed: () {}, child: const Text('English')),
                    ElevatedButton(onPressed: () {}, child: const Text('Gujarati')),
                  ],
                ),
              ],
            ),
            VanchanScreen()
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Vanchan'),
        BottomNavigationBarItem(icon: Icon(Icons.rebase_edit), label: 'Malajap')
      ]),
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
