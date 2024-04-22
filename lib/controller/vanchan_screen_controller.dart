import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ghanshyam_mahotsav/model/global_response.dart';
import 'package:ghanshyam_mahotsav/model/pdf_listing_response.dart';
import 'package:ghanshyam_mahotsav/network/api_config.dart';
import 'package:ghanshyam_mahotsav/network/api_strings.dart';

class VanchanScreenController extends GetxController {
  final RxString selectedLanguage = 'English'.obs;
  final TextEditingController searchText = TextEditingController();
  final ApiBaseHelper apiBaseHelper = ApiBaseHelper();
  final List<PdfListingResponse> allPDFListing = <PdfListingResponse>[].obs;
  final RxBool isLoading = true.obs;
  getAllPDF() async {
    isLoading.value = true;
    var apiRes = await apiBaseHelper.getData(leadAPI: ApiStrings.kPDFListing);
    GlobalResponse globalResponse = GlobalResponse.fromJson(apiRes);
    isLoading.value = false;
    if (globalResponse.status == 200) {
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
