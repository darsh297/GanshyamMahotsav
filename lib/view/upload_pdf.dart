import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as path;

import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

// <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />

class Extra extends StatelessWidget {
  Extra({super.key});

  final AppTextStyle appTextStyle = AppTextStyle();
  RxString filePath = ''.obs;
  RxString selectedLanguage = 'Select Language'.obs;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: AppColors.scaffoldColor,
        appBar: AppBar(
          title: Text('Upload PDF'),
          centerTitle: true,
          automaticallyImplyLeading: true,
        ),
        body: Container(
          height: Get.height,
          width: Get.width,
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: AppColors.white,
          ),
          child: Column(
            children: [
              InkWell(
                onTap: () => pickPDFFile(),
                child: Container(
                  height: Get.height / 2.3,
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
                    child: Obx(() => filePath.value.isNotEmpty
                        ? Center(
                            child: Text(
                              'Selected PDF: ${path.basenameWithoutExtension(filePath.value)}',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                                  style: appTextStyle.montserrat16W500Grey,
                                )
                              ],
                            ),
                          )),
                  ),
                ),
              ),
              const SizedBox(height: 25),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Select PDF language',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey), // Change to your desired border color
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        borderRadius: BorderRadius.circular(4),
                        isExpanded: true,
                        value: selectedLanguage.value, // Initialize value to your selected language
                        onChanged: (String? newValue) {
                          selectedLanguage.value = newValue!;
                        },
                        items: ['Select Language', 'English', 'Spanish', 'French'] // Add more languages as needed
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(value),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Upload PDF'),
                ),
              ),
            ],
          ),
        ),
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
        filePath.value = result.files.single.path ?? '';
      }
    } catch (e) {
      print('Error picking PDF file: $e');
    }
  }
}
