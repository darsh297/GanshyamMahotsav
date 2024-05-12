// import 'dart:developer';

import 'package:get/get.dart';
import 'package:ghanshyam_mahotsav/model/global_response.dart';
import 'package:ghanshyam_mahotsav/model/user_data_list_model.dart';
import 'package:ghanshyam_mahotsav/network/api_config.dart';
import 'package:ghanshyam_mahotsav/network/api_strings.dart';
import 'package:ghanshyam_mahotsav/widgets/widgets.dart';

class UserDataListController extends GetxController {
  final ApiBaseHelper apiBaseHelper = ApiBaseHelper();
  final RxList<UserDataListModel> userDataList = <UserDataListModel>[].obs;
  final RxBool isLoading = true.obs;
  final RxBool isLoadingMore = false.obs;
  final RxBool fileDownloadLoader = false.obs;
  // For lazy loading () -> If user has scrolled-up and lazy loading (pagination's) next page data API is already called then new API with next page do not call again
  final RxBool allDataReceived = false.obs; // if all data is fetched then make it true
  getAllUserData({String? queryParam, int page = 1}) async {
    if (allDataReceived.value == false) {
      var url = ApiStrings.kGetAllUsers;
      // url += '?page=$page';
      if (queryParam != null && queryParam != 'All') {
        url += queryParam;
      }

      var api = await apiBaseHelper.getData(leadAPI: url);
      GlobalResponse globalResponse = GlobalResponse.fromJson(api);
      isLoading.value = false;
      if (globalResponse.status == 200) {
        List<dynamic> pdfList = [];
        if (globalResponse.data != null) {
          pdfList = globalResponse.data;
          List<UserDataListModel> userResponse = [];
          if (pdfList.isNotEmpty) {
            // List to single from API
            for (var item in pdfList) {
              UserDataListModel pdfListingResponse = UserDataListModel.fromJson(item);
              userResponse.add(pdfListingResponse);
            }
            if (queryParam != null) {
              userDataList.value = [];
            }
            userDataList.addAll(userResponse);
          } else {
            print('|||||||||||||||||||||||||||||||||||||||||||');
            isLoading.value = false;
            allDataReceived.value = true;
          }
        }
      }
    }
  }

  downloadExcel() async {
    fileDownloadLoader.value = true;
    bool successful = await apiBaseHelper.downloadFile();
    fileDownloadLoader.value = false;
    if (successful) {
      CustomWidgets.toastValidation(msg: 'File downloaded successfully');
    } else {
      CustomWidgets.toastValidation(msg: 'Something went wrong');
    }
  }
}
