import 'package:get/get.dart';
import 'package:ghanshyam_mahotsav/model/global_response.dart';
import 'package:ghanshyam_mahotsav/network/api_config.dart';
import 'package:ghanshyam_mahotsav/network/api_strings.dart';

import '../utils/app_text_styles.dart';
import '../widgets/widgets.dart';

class UploadPDFController extends GetxController {
  final ApiBaseHelper apiBaseHelper = ApiBaseHelper();
  final AppTextStyle appTextStyle = AppTextStyle();
  final RxBool isLoading = false.obs;
  final RxString filePath = ''.obs;
  final RxString selectedLanguage = 'Select Language'.obs;
  uploadPDF(String filePath) async {
    isLoading.value = true;
    var apiRes = await apiBaseHelper.uploadFiles(filePath: filePath, language: selectedLanguage.value, leadAPI: ApiStrings.kUploadPDF);
    GlobalResponse globalResponse = GlobalResponse.fromJson(apiRes);
    isLoading.value = false;
    if (globalResponse.status == 200) {
      CustomWidgets.toastValidation(msg: globalResponse.message ?? '');
      Get.back();
    } else {
      CustomWidgets.toastValidation(msg: 'PDf can not uploaded:${globalResponse.message}');
    }
  }
}
