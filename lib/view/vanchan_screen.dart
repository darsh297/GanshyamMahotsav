import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ghanshyam_mahotsav/controller/vanchan_screen_controller.dart';
import 'package:ghanshyam_mahotsav/utils/app_colors.dart';
import 'package:ghanshyam_mahotsav/utils/app_text_styles.dart';
import 'package:ghanshyam_mahotsav/view/pdf_view_page.dart';
import 'package:ghanshyam_mahotsav/widgets/custom_textfield.dart';
import '../widgets/widgets.dart';

class VanchanScreen extends StatefulWidget {
  const VanchanScreen({super.key});

  @override
  State<VanchanScreen> createState() => _VanchanScreenState();
}

class _VanchanScreenState extends State<VanchanScreen> {
  final VanchanScreenController vanchanScreenController = Get.find();
  AppTextStyle appTextStyle = AppTextStyle();
  @override
  void initState() {
    vanchanScreenController.getAllPDF();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          CustomTextFields(
            textFieldController: vanchanScreenController.searchText,
            hintText: 'Search PDF by Name',
            leadingIcon: const Icon(Icons.search_sharp),
            onChange: (value) => vanchanScreenController.getAllPDF(queryParam: '?fileName=$value'),
            inputBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.white)),
            trailingIcon: IconButton(
                icon: const Icon(Icons.cancel),
                onPressed: () {
                  if (vanchanScreenController.searchText.text != '') {
                    vanchanScreenController.getAllPDF();
                    vanchanScreenController.searchText.text = '';
                  }
                }),
          ),
          // Container(
          //   margin: const EdgeInsets.only(left: 8),
          //   decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(8)),
          //   child: PopupMenuButton<String>(
          //     icon: const Icon(Icons.language), // Set the icon
          //     onSelected: (value) {
          //       // vanchanScreenController.selectedLanguage.value = value;
          //       (value != 'All') ? vanchanScreenController.getAllPDF(queryParam: '?language=$value') : vanchanScreenController.getAllPDF();
          //     },
          //     itemBuilder: (BuildContext context) {
          //       return ['All', 'English', 'Gujarati'].map((String language) {
          //         return PopupMenuItem<String>(
          //           value: language.tr,
          //           child: Text(language),
          //         );
          //       }).toList();
          //     },
          //   ),
          // ),
          // const SizedBox(height: 18),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.52,
            child: Obx(
              () => !vanchanScreenController.isLoading.value
                  ? vanchanScreenController.allPDFListing.isNotEmpty
                      ? GridView.builder(
                          shrinkWrap: true,
                          padding: const EdgeInsets.only(top: 18, left: 12, right: 12),
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            // childAspectRatio: 1,
                            mainAxisExtent: 200, // fix height of child
                            crossAxisSpacing: 30,
                            mainAxisSpacing: 15, //vertical gap
                          ),
                          itemCount: vanchanScreenController.allPDFListing.length,
                          itemBuilder: (context, index) {
                            var pdfData = vanchanScreenController.allPDFListing;
                            return InkWell(
                              onTap: () =>
                                  Get.to(() => PDFViewerFromUrl(url: 'https://gm-files.blr1.cdn.digitaloceanspaces.com/pdfs/${pdfData[index].fileName}')),
                              // color: Colors.red,
                              child: Column(
                                children: [
                                  Container(
                                      height: 120,
                                      width: 100,
                                      decoration: BoxDecoration(color: AppColors.grey3, borderRadius: BorderRadius.circular(20)),
                                      child: Image.network(
                                        'https://gm-files.blr1.cdn.digitaloceanspaces.com/images/${pdfData[index].image}',
                                        // height: 20,
                                      )),
                                  Text(
                                    '${pdfData[index].fileName}',
                                    style: appTextStyle.montserrat12W500,
                                  ),
                                  // Text('${pdfData[index].language}'),
                                  Text(
                                    pdfData[index].description ?? '',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: appTextStyle.montserrat10W500Grey,
                                  ),
                                ],
                              ),
                            );
                          },
                        )
                      // ? ListView.builder(
                      //     physics: const AlwaysScrollableScrollPhysics(),
                      //     shrinkWrap: true,
                      //     itemCount: vanchanScreenController.allPDFListing.length,
                      //     itemBuilder: (context, index) {
                      //       var pdfData = vanchanScreenController.allPDFListing;
                      //       return Card(
                      //         margin: const EdgeInsets.symmetric(vertical: 10),
                      //         child: ListTile(
                      //           onTap: () => Get.to(() => PDFViewerFromUrl(url: 'https://gm-backend-1fve.onrender.com/files/${pdfData[index].fileName}')),
                      //           contentPadding: const EdgeInsets.all(8),
                      //           leading: Container(
                      //             height: 100,
                      //             width: 60,
                      //             decoration: BoxDecoration(
                      //               borderRadius: BorderRadius.circular(10),
                      //               color: AppColors.scaffoldColor.withOpacity(0.2),
                      //             ),
                      //             child: Image.asset('assets/Ghanshyam Stotram Eng.jpg'),
                      //             // child: const Icon(Icons.picture_as_pdf),
                      //           ),
                      //           title: Text(
                      //             '${pdfData[index].fileName}',
                      //             style: appTextStyle.montserrat16,
                      //           ),
                      //           subtitle: Column(
                      //             crossAxisAlignment: CrossAxisAlignment.start,
                      //             children: [
                      //               Text('${pdfData[index].language}'),
                      //               Text(
                      //                 'Lorem ipsum is placeholder text commonly used in the graphic, print, and publishing industries for previewing '
                      //                 'layouts and visual mockups',
                      //                 maxLines: 2,
                      //                 overflow: TextOverflow.ellipsis,
                      //                 style: appTextStyle.montserrat10W500Grey,
                      //               ),
                      //             ],
                      //           ),
                      //           // isThreeLine: true,
                      //         ),
                      //       );
                      //     },
                      //   )
                      : Center(child: Text('No PDF found'.tr))
                  : CustomWidgets.loader,
            ),
          ),
        ],
      ),
    );
  }
}
