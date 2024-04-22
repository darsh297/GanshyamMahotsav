import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ghanshyam_mahotsav/controller/user_data_list_controller.dart';
import 'package:ghanshyam_mahotsav/utils/app_colors.dart';

///User data list

class UserDataWidget extends StatefulWidget {
  const UserDataWidget({super.key});

  @override
  _UserDataWidgetState createState() => _UserDataWidgetState();
}

class _UserDataWidgetState extends State<UserDataWidget> {
  final UserDataListController userDataListController = Get.put(UserDataListController());

  @override
  void initState() {
    userDataListController.getAllUserData();
    super.initState();
  }

  // final RxBool isExpanded = true.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: AppBar(
        title: const Text('User Data List'),
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
                              Text('Mobile: ${userData.phoneNumber}'),
                              Text('Total Credits: ${userData.creditCount}'),
                            ],
                          ),
                          // isThreeLine: true,
                          onTap: () {
                            print('isExpanded.value:${userData.isExpand.value}');

                            userData.isExpand.value = !userData.isExpand.value;
                            print('isExpanded.value:${userData.isExpand.value}');
                          },
                        ),
                        // Show credits only when the tile is tapped (expanded)
                        Obx(
                          () => (userData.isExpand.value)
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: userData.creditList?.length,
                                    itemBuilder: (context, index) {
                                      return Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Text('Date: ${userData.creditList?[index].date}'),
                                          Text('Credits: ${userData.creditList?[index].count}'),
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
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SizedBox())
        ],
      ),
    );
  }
}
