import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ghanshyam_mahotsav/utils/app_text_styles.dart';
import 'package:ghanshyam_mahotsav/utils/string_utils.dart';
import 'package:ghanshyam_mahotsav/view/drawer_screen.dart';
import 'package:ghanshyam_mahotsav/view/mala_jap_screen.dart';
import 'package:ghanshyam_mahotsav/view/pdf_view_page.dart';
import 'package:ghanshyam_mahotsav/view/vanchan_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/vanchan_screen_controller.dart';
import '../utils/app_colors.dart';
import '../utils/shared_preference.dart';
import '../utils/widgets.dart';
import '../widgets/custom_textfield.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Rx<TextEditingController> searchTextEditingController = TextEditingController().obs;

  final RxBool isListView = true.obs;
  final RxBool isPDFView = true.obs;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final AppTextStyle appTextStyle = AppTextStyle();

  @override
  void initState() {
    vanchanScreenController.getAllPDF();
    super.initState();
  }

  VanchanScreenController vanchanScreenController = Get.put(VanchanScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.scaffoldColor,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => _scaffoldKey.currentState?.openDrawer(),
          )),
      drawer: const DrawerScreen(),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text('Welcome, Username'),
        Obx(() => isPDFView.value ? VanchanScreen() : MalaJapScreen()),
        InkWell(
          onTap: () {
            isPDFView.value = !isPDFView.value;
          },
          child: Container(
            height: MediaQuery.of(context).size.height * 0.05,
            width: Get.width,
            alignment: Alignment.center,
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(color: AppColors.primaryColor, borderRadius: BorderRadius.circular(10)),
            child: Text(
              'Go to Malajap',
              style: appTextStyle.montserrat14W500,
            ),
          ),
        )
      ]),
    );
  }
}

class MenuCard extends StatelessWidget {
  const MenuCard({
    super.key,
    required this.imageUrl,
    required this.cardName,
    required this.isMalaJap,
  });
  final bool isMalaJap;
  final String imageUrl;
  final String cardName;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(() => isMalaJap ? const MalaJapScreen() : const VanchanScreen()),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.primaryColor,
          border: Border.all(color: AppColors.white, width: 4),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 3,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        height: 250,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.network(
              imageUrl,
              height: 120,
            ),
            const Divider(),
            Text(
              cardName.tr,
              style: TextStyle(fontSize: 20, color: AppColors.white),
            )
          ],
        ),
      ),
    );
  }
}
