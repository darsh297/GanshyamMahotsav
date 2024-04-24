import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ghanshyam_mahotsav/controller/vanchan_screen_controller.dart';
import 'package:ghanshyam_mahotsav/utils/app_colors.dart';
import 'package:ghanshyam_mahotsav/view/pdf_view_page.dart';
import 'package:ghanshyam_mahotsav/widgets/custom_textfield.dart';

import '../utils/widgets.dart';

class VanchanScreen extends StatefulWidget {
  const VanchanScreen({super.key});

  @override
  State<VanchanScreen> createState() => _VanchanScreenState();
}

class _VanchanScreenState extends State<VanchanScreen> {
  VanchanScreenController vanchanScreenController = Get.find();

  @override
  void initState() {
    vanchanScreenController.getAllPDF();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Stack(
        children: [
          Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: CustomTextFields(
                      textFieldController: vanchanScreenController.searchText,
                      hintText: 'Search PDF by Name',
                      leadingIcon: const Icon(Icons.search_sharp),
                      onChange: (value) {
                        vanchanScreenController.getAllPDF(queryParam: '?fileName=$value');
                      },
                      inputBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.white)),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 8),
                    decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(8)),
                    child: PopupMenuButton<String>(
                      icon: const Icon(Icons.language), // Set the icon
                      onSelected: (value) {
                        vanchanScreenController.selectedLanguage.value = value;
                        if (value != 'All') {
                          vanchanScreenController.getAllPDF(queryParam: '?language=$value');
                        } else {
                          print(value);
                          vanchanScreenController.getAllPDF();
                        }
                      },
                      itemBuilder: (BuildContext context) {
                        return ['All', 'English', 'Gujarati'].map((String language) {
                          return PopupMenuItem<String>(
                            value: language.tr,
                            child: Text(language),
                          );
                        }).toList();
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.68,
                child: Obx(
                  () => vanchanScreenController.allPDFListing.isNotEmpty
                      ? ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: vanchanScreenController.allPDFListing.length,
                          // itemCount: 10,
                          itemBuilder: (context, index) {
                            var pdfData = vanchanScreenController.allPDFListing;
                            return Card(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              child: ListTile(
                                onTap: () => Get.to(() => PDFViewerFromUrl(url: 'https://gm-backend-1fve.onrender.com/files/${pdfData[index].fileName}')),
                                contentPadding: const EdgeInsets.all(10),
                                leading: const SizedBox(
                                  height: 50,
                                  width: 40,
                                  child: Icon(Icons.picture_as_pdf),
                                ),
                                title: Text('${pdfData[index].fileName}'),
                                subtitle: Text('${pdfData[index].language}'),
                              ),
                            );
                          },
                        )
                      : Center(child: Text('No PDF found'.tr)),
                ),
              ),
            ],
          ),
          Obx(
            () => vanchanScreenController.isLoading.value
                ? Container(
                    width: Get.width,
                    height: MediaQuery.of(context).size.height * 0.76,
                    color: AppColors.lightBorder.withOpacity(0.8),
                    child: CustomWidgets.loader,
                  )
                : const SizedBox(height: 0, width: 0),
          ),
        ],
      ),
    );
  }
}
