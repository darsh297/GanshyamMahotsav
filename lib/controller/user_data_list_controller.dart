// import 'dart:developer';

import 'package:get/get.dart';
import 'package:ghanshyam_mahotsav/model/global_response.dart';
import 'package:ghanshyam_mahotsav/model/user_data_list_model.dart';
import 'package:ghanshyam_mahotsav/network/api_config.dart';
import 'package:ghanshyam_mahotsav/network/api_strings.dart';

class UserDataListController extends GetxController {
  final ApiBaseHelper apiBaseHelper = ApiBaseHelper();
  final RxList<UserDataListModel> userDataList = <UserDataListModel>[].obs;
  final RxBool isLoading = false.obs;
  getAllUserData({String? queryParam}) async {
    isLoading.value = true;
    var url = ApiStrings.kGetAllUsers;
    if (queryParam != null) {
      url += queryParam;
    }
    var api = await apiBaseHelper.getData(leadAPI: url);
    GlobalResponse globalResponse = GlobalResponse.fromJson(api);
    isLoading.value = false;
    if (globalResponse.status == 200) {
      userDataList.value = [];
      List<dynamic> pdfList = globalResponse.data;
      List<UserDataListModel> pdfResponses = [];

      for (var item in pdfList) {
        UserDataListModel pdfListingResponse = UserDataListModel.fromJson(item);
        pdfResponses.add(pdfListingResponse);
      }
      userDataList.addAll(pdfResponses);
    }
  }
}
