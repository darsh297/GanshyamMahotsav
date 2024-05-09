import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ghanshyam_mahotsav/model/global_response.dart';
import 'package:ghanshyam_mahotsav/model/pdf_listing_response.dart';
import 'package:ghanshyam_mahotsav/network/api_config.dart';
import 'package:ghanshyam_mahotsav/network/api_strings.dart';

import '../utils/string_utils.dart';

class VanchanScreenController extends GetxController {
  final RxString selectedLanguage = StringUtils.english.obs;
  final TextEditingController searchText = TextEditingController();
  final ApiBaseHelper apiBaseHelper = ApiBaseHelper();
  final RxList<PdfListingResponse> allPDFListing = <PdfListingResponse>[].obs;
  final RxBool isLoading = true.obs;
  getAllPDF({String? queryParamLanguage, String? queryParamSearch}) async {
    isLoading.value = true;
    var url = ApiStrings.kPDFListing;
    if (queryParamLanguage != null && queryParamSearch != null) {
      url += '?language=$queryParamLanguage&fileName=$queryParamSearch';
    } else if (queryParamLanguage != null) {
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
}
