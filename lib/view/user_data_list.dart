import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ghanshyam_mahotsav/controller/user_data_list_controller.dart';
import 'package:ghanshyam_mahotsav/utils/app_colors.dart';
import 'package:ghanshyam_mahotsav/utils/app_text_styles.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../widgets/widgets.dart';

///User data list

class UserDataWidget extends StatefulWidget {
  const UserDataWidget({super.key});

  @override
  State<UserDataWidget> createState() => _UserDataWidgetState();
}

class _UserDataWidgetState extends State<UserDataWidget> {
  final UserDataListController userDataListController = Get.put(UserDataListController());
  final AppTextStyle appTextStyle = AppTextStyle();
  final ScrollController scrollController = ScrollController();
  int pageNumber = 1;
  String queryParam = '';
  @override
  void initState() {
    pageNumber = 1;
    userDataListController.getAllUserData();
    scrollController.addListener(() => _scrollListener());
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: AppColors.scaffoldColor));
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: AppColors.scaffoldColor));
    super.dispose();
  }

  Future<void> _scrollListener() async {
    if (userDataListController.allDataReceived.value || userDataListController.isLoadingMore.value) return;

    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      userDataListController.isLoadingMore.value = true;
      pageNumber += 1;
      await userDataListController.getAllUserData(
        page: pageNumber,
        queryParam: '?filter=$queryParam',
      );
      userDataListController.isLoadingMore.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: AppBar(
        title: Text('User Data List'.tr, style: TextStyle(color: AppColors.white)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.white),
          onPressed: () => Get.back(),
        ),
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.filter_alt, color: AppColors.white),
            onSelected: (value) {
              if (value == 'Last Month') {
                queryParam = 'lastMonth';
              } else if (value == 'Last Week') {
                queryParam = 'lastWeek';
              } else if (value == 'All') {
                queryParam = 'All';
              }
              userDataListController.allDataReceived.value = false;
              userDataListController.isLoading.value = true;
              pageNumber = 1;
              userDataListController.getAllUserData(queryParam: '?filter=$queryParam');
              // (value != 'All') ? userDataListController.getAllUserData(queryParam: '?filter=$queryParam') : userDataListController.getAllUserData();
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
            () => userDataListController.isLoading.value
                ? CustomWidgets.loader
                : userDataListController.userDataList.isNotEmpty
                    ? ListView.builder(
                        controller: scrollController,
                        itemCount: userDataListController.isLoadingMore.value
                            ? userDataListController.userDataList.length + 1
                            : userDataListController.userDataList.length,
                        itemBuilder: (context, index) {
                          if (index < userDataListController.userDataList.length) {
                            final userData = userDataListController.userDataList[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                              child: Card(
                                elevation: 4,
                                child: Column(
                                  children: [
                                    ListTile(
                                      leading: CircleAvatar(
                                        // You can set user profile images here
                                        child: Text('${index + 1}'),
                                      ),
                                      title: Text(userData.fullName ?? ''),
                                      subtitle: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('${'Mobile No'.tr} : ${userData.phoneNumber}'),
                                          Text('${'Village'.tr} : ${userData.village ?? ''}'),
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
                          } else {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: CustomWidgets.loader,
                            );
                          }
                        },
                      )
                    : Center(child: Text('No Data Found', style: appTextStyle.montserrat14W500)),
          ),
          // Obx(() => userDataListController.isLoading.value
          //     ? Container(
          //         color: AppColors.lightBorder.withOpacity(0.8),
          //         child: CustomWidgets.loader,
          //       )
          //     : const SizedBox())
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Obx(
          () => !userDataListController.fileDownloadLoader.value
              ? ElevatedButton(
                  child: Text('Download Excel'.tr),
                  onPressed: () {
                    userDataListController.downloadExcel();
                  },
                )
              : Container(
                  height: 40,
                  width: double.infinity,
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(color: AppColors.primaryColor, borderRadius: BorderRadius.circular(5)),
                  child: Center(
                    child: LoadingAnimationWidget.threeArchedCircle(color: AppColors.scaffoldColor, size: 40),
                  ),
                ),
        ),
      ),
    );
  }
}
