import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ghanshyam_mahotsav/controller/user_data_list_controller.dart';
import 'package:ghanshyam_mahotsav/utils/app_colors.dart';

import '../widgets/widgets.dart';

///User data list

class UserDataWidget extends StatefulWidget {
  const UserDataWidget({super.key});

  @override
  State<UserDataWidget> createState() => _UserDataWidgetState();
}

class _UserDataWidgetState extends State<UserDataWidget> {
  final UserDataListController userDataListController = Get.put(UserDataListController());

  @override
  void initState() {
    userDataListController.getAllUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: AppBar(
        title: Text('User Data List'.tr, style: TextStyle(color: AppColors.white)),
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.filter_alt, color: AppColors.white),
            onSelected: (value) {
              (value != 'All') ? userDataListController.getAllUserData(queryParam: '?filter=$value') : userDataListController.getAllUserData();
            },
            itemBuilder: (BuildContext context) {
              return ['All', 'Last Month', 'Last Week'].map((String language) {
                return PopupMenuItem<String>(
                  value: language,
                  child: Text(language.tr),
                );
              }).toList();
            },
          )
        ],
      ),
      body: Stack(
        children: [
          Obx(
            () => ListView.builder(
              itemCount: userDataListController.userDataList.length,
              itemBuilder: (context, index) {
                final userData = userDataListController.userDataList[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Card(
                    elevation: 4,
                    child: Column(
                      children: [
                        ListTile(
                          leading: const CircleAvatar(
                            // You can set user profile images here
                            child: Icon(Icons.person),
                          ),
                          title: Text(userData.fullName ?? ''),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('${'Mobile No'.tr} : ${userData.phoneNumber}'),
                              Text('${'Village'.tr} : ${userData.creditCount}'),
                              Text('${'Total Credits'.tr} : ${userData.creditCount}'),
                            ],
                          ),
                          onTap: () {
                            userData.isExpand.value = !userData.isExpand.value;
                          },
                        ),
                        // Show credits only when the tile is tapped (expanded)
                        Obx(
                          () => (userData.isExpand.value)
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                                  child: ListView.builder(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    shrinkWrap: true,
                                    itemCount: userData.creditList?.length,
                                    itemBuilder: (context, index) {
                                      return Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('${'Date'.tr} : ${userData.creditList?[index].date}'),
                                          Text('${'Credits'.tr} :${userData.creditList?[index].count}'),
                                        ],
                                      );
                                    },
                                  ))
                              : const SizedBox(),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Obx(() => userDataListController.isLoading.value
              ? Container(
                  color: AppColors.lightBorder.withOpacity(0.8),
                  child: CustomWidgets.loader,
                )
              : const SizedBox())
        ],
      ),
    );
  }
}
