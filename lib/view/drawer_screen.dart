// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../utils/app_colors.dart';
// import '../utils/app_text_styles.dart';
// import '../utils/shared_preference.dart';
// import '../utils/string_utils.dart';
//
// class DrawerScreen extends StatefulWidget {
//   const DrawerScreen({super.key});
//
//   @override
//   State<DrawerScreen> createState() => _DrawerScreenState();
// }
//
// class _DrawerScreenState extends State<DrawerScreen> {
//   final RxString _selectedLanguage = StringUtils.english.obs;
//   final SharedPreferenceClass sharedPreferenceClass = SharedPreferenceClass();
//   final AppTextStyle appTextStyle = AppTextStyle();
//   final RxBool isAdmin = false.obs;
//   final RxInt credits = 0.obs;
//   final RxString userName = ''.obs;
//
//   @override
//   void initState() {
//     getIfAdmin();
//     super.initState();
//   }
//
//   getIfAdmin() async {
//     isAdmin.value = await sharedPreferenceClass.retrieveData(StringUtils.prefIsAdmin);
//     credits.value = await sharedPreferenceClass.retrieveData(StringUtils.prefUserCredit);
//     userName.value = await sharedPreferenceClass.retrieveData(StringUtils.prefUserName);
//     _selectedLanguage.value = await sharedPreferenceClass.retrieveData(StringUtils.prefLanguage) ?? 'English';
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Stack(
//             alignment: Alignment.center,
//             children: [
//               Column(
//                 children: [
//                   Container(
//                     height: 150,
//                     padding: const EdgeInsets.only(top: 40),
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                       borderRadius: const BorderRadius.only(
//                         bottomLeft: Radius.circular(20),
//                         bottomRight: Radius.circular(20),
//                       ),
//                       color: AppColors.primaryColor,
//                       border: Border(bottom: BorderSide(color: AppColors.white, width: 1)),
//                       boxShadow: [
//                         BoxShadow(
//                           color: AppColors.black.withOpacity(0.2),
//                           spreadRadius: 2,
//                           blurRadius: 3,
//                           offset: const Offset(0, 3),
//                         ),
//                       ],
//                     ),
//                     child: Obx(
//                       () => Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           Text(
//                             userName.value,
//                             style: appTextStyle.montserrat14W600White,
//                           ),
//                           Text(
//                             'Credit Score : ${credits.value}',
//                             style: appTextStyle.montserrat14W600White,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           // const SizedBox(height: 10),
//           // DrawerTile(title: 'Home', icons: const Icon(Icons.home), onTap: () => Get.back()),
//         ],
//       ),
//     );
//   }
// }
