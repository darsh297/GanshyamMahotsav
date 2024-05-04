import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ghanshyam_mahotsav/controller/upload_pdf_controller.dart';
import 'package:ghanshyam_mahotsav/utils/app_text_styles.dart';
import 'package:path/path.dart' as path;
import '../utils/app_colors.dart';
import '../widgets/custom_textfield.dart';
import '../widgets/widgets.dart';

class UploadPDF extends StatelessWidget {
  UploadPDF({super.key});

  final UploadPDFController uploadPDFController = Get.put(UploadPDFController());
  final TextEditingController description = TextEditingController();
  final AppTextStyle appTextStyle = AppTextStyle();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: AppBar(
        title: Text(
          'Upload PDF',
          style: appTextStyle.montserrat20W500White,
        ),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: Stack(
        children: [
          Container(
            height: Get.height,
            width: Get.width,
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: AppColors.white,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  InkWell(
                    onTap: () => pickPDFFile(),
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 12),
                      height: Get.height / 2.8,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: AppColors.lightGrey,
                      ),
                      child: DottedBorder(
                        radius: const Radius.circular(6),
                        borderType: BorderType.RRect,
                        dashPattern: const [6, 6],
                        strokeWidth: 2,
                        color: AppColors.grey1,
                        child: Obx(
                          () => uploadPDFController.filePath.value.isNotEmpty
                              ? Center(
                                  child: Text(
                                    'Selected PDF: ${path.basenameWithoutExtension(uploadPDFController.filePath.value)}',
                                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                )
                              : Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.picture_as_pdf_rounded,
                                        size: 50,
                                        color: AppColors.grey,
                                      ),
                                      const SizedBox(height: 20),
                                      Text(
                                        "Click here to upload PDF",
                                        textAlign: TextAlign.center,
                                        style: uploadPDFController.appTextStyle.montserrat16W500Grey,
                                      )
                                    ],
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => pickPDFFile(),
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 12),
                      height: Get.height / 4,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: AppColors.lightGrey,
                      ),
                      child: DottedBorder(
                        radius: const Radius.circular(6),
                        borderType: BorderType.RRect,
                        dashPattern: const [6, 6],
                        strokeWidth: 2,
                        color: AppColors.grey1,
                        child: Obx(
                          () => uploadPDFController.filePath.value.isNotEmpty
                              ? Center(
                                  child: Text(
                                    'Selected PDF: ${path.basenameWithoutExtension(uploadPDFController.filePath.value)}',
                                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                )
                              : Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.image,
                                        size: 50,
                                        color: AppColors.grey,
                                      ),
                                      const SizedBox(height: 20),
                                      Text(
                                        "Click here to upload PDF Photo".tr,
                                        textAlign: TextAlign.center,
                                        style: uploadPDFController.appTextStyle.montserrat16W500Grey,
                                      )
                                    ],
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  CustomTextFields(
                    textFieldController: description,
                    textFieldName: 'PDF Description',
                    maxLine: 2,
                    maxLength: 40,
                  ),

                  /// Language Dropdown
                  const SizedBox(height: 12),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Select PDF language',
                        style: appTextStyle.montserrat14W600,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey), // Change to your desired border color
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Obx(
                          () => DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              borderRadius: BorderRadius.circular(4),
                              isExpanded: true,
                              value: uploadPDFController.selectedLanguage.value, // Initialize value to your selected language
                              onChanged: (String? newValue) {
                                uploadPDFController.selectedLanguage.value = newValue!;
                              },
                              items: ['Select Language', 'English', 'Gujarati'] // Add more languages as needed
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                    child: Text(
                                      value,
                                      style: appTextStyle.montserrat14W600,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  /// Upload Button
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (uploadPDFController.selectedLanguage.value != 'Select Language' && uploadPDFController.filePath.value != '') {
                          uploadPDFController.uploadPDF(uploadPDFController.filePath.value);
                        } else {
                          CustomWidgets.toastValidation(msg: 'Select PDF and PDF language');
                        }
                      },
                      child: const Text('Upload PDF'),
                    ),
                  )
                ],
              ),
            ),
          ),
          Obx(
            () => uploadPDFController.isLoading.value
                ? Container(
                    color: AppColors.lightBorder.withOpacity(0.8),
                    child: CustomWidgets.loader,
                  )
                : const SizedBox(height: 0, width: 0),
          ),
        ],
      ),
    );
  }

  Future<void> pickPDFFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );
      if (result != null) {
        uploadPDFController.filePath.value = result.files.single.path ?? '';
      }
    } catch (e) {
      debugPrint('$e');
    }
  }
}
