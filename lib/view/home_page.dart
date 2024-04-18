import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ghanshyam_mahotsav/view/drawer_screen.dart';
import 'package:ghanshyam_mahotsav/view/mala_jap_screen.dart';
import 'package:ghanshyam_mahotsav/view/vanchan_screen.dart';

import '../utils/app_colors.dart';
import 'extra.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final Rx<TextEditingController> searchTextEditingController = TextEditingController().obs;
  final RxBool isListView = true.obs;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.scaffoldColor,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => _scaffoldKey.currentState?.openDrawer(),
          )),
      drawer: DrawerScreen(),
      body: const SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: [
            MenuCard(
              imageUrl:
                  'https://www.swaminarayan.faith/media/2449/mahraj-writting-a-letter.jpg?anchor=center&mode=crop&width=400&height=300&rnd=132019680760000000',
              cardName: 'Vanchan',
              isMalaJap: false,
            ),
            MenuCard(
              imageUrl:
                  'https://www.swaminarayan.faith/media/2449/mahraj-writting-a-letter.jpg?anchor=center&mode=crop&width=400&height=300&rnd=132019680760000000',
              cardName: 'Mala Jap',
              isMalaJap: true,
            ),
          ],
        ),
      ),
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
              color: Colors.white.withOpacity(0.1),
              spreadRadius: 0,
              blurRadius: 3,
              offset: const Offset(0, 1.5),
            ),
          ],
        ),
        height: 250,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              imageUrl,
              height: 100,
            ),
            const Divider(),
            Text(
              cardName,
              style: TextStyle(fontSize: 20, color: AppColors.white),
            )
          ],
        ),
      ),
    );
  }
}
