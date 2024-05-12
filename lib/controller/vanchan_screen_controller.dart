import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ghanshyam_mahotsav/model/global_response.dart';
import 'package:ghanshyam_mahotsav/model/pdf_listing_response.dart';
import 'package:ghanshyam_mahotsav/network/api_config.dart';
import 'package:ghanshyam_mahotsav/network/api_strings.dart';
import 'package:ghanshyam_mahotsav/utils/shared_preference.dart';
import 'package:ghanshyam_mahotsav/widgets/widgets.dart';

import '../utils/string_utils.dart';

class VanchanScreenController extends GetxController {
  final RxString selectedLanguage = StringUtils.english.obs;
  final TextEditingController searchText = TextEditingController();
  final SharedPreferenceClass sharedPreferenceClass = SharedPreferenceClass();
  final ApiBaseHelper apiBaseHelper = ApiBaseHelper();
  final RxList<PdfListingResponse> allPDFListing = <PdfListingResponse>[].obs;
  final RxBool isLoading = true.obs;
  final RxBool deleteBookLoading = false.obs;
  final RxBool isAdmin = false.obs;
  getAllPDF({String? queryParamLanguage, String? queryParamSearch}) async {
    isLoading.value = true;
    var url = ApiStrings.kPDFListing;
    if (queryParamLanguage != null && queryParamSearch != null && queryParamLanguage != 'All') {
      url += '?language=$queryParamLanguage&fileName=$queryParamSearch';
    } else if (queryParamLanguage != null && queryParamLanguage != 'All') {
      url += '?language=$queryParamLanguage';
    } else if (queryParamSearch != null) {
      url += '?fileName=$queryParamSearch';
    }
    var apiRes = await apiBaseHelper.getData(leadAPI: url); //?language=English
    GlobalResponse globalResponse = GlobalResponse.fromJson(apiRes);
    isLoading.value = false;
    if (globalResponse.status == 200) {
      allPDFListing.value = [];
      List<dynamic> pdfList = globalResponse.data;
      List<PdfListingResponse> pdfResponses = [];

      for (var item in pdfList) {
        PdfListingResponse pdfListingResponse = PdfListingResponse.fromJson(item);
        pdfResponses.add(pdfListingResponse);
      }
      allPDFListing.addAll(pdfResponses);
    } else {}
  }

  deleteBook(pdfId, pdfIndex) async {
    deleteBookLoading.value = true;
    var apiResponse = await apiBaseHelper.deleteDataAPI(leadAPI: 'pdf/$pdfId');
    GlobalResponse globalResponse = GlobalResponse.fromJson(apiResponse);
    deleteBookLoading.value = false;
    if (globalResponse.status == 200) {
      CustomWidgets.toastValidation(msg: globalResponse.message ?? '');
      allPDFListing.removeAt(pdfIndex);
    }
    Get.back();
  }

  adminData() async {
    isAdmin.value = await sharedPreferenceClass.retrieveData(StringUtils.prefIsAdmin);
  }
}
