import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ghanshyam_mahotsav/controller/home_controller.dart';
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
  final HomeController homeController = Get.find();
  AppTextStyle appTextStyle = AppTextStyle();
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: AppColors.scaffoldColor));
    vanchanScreenController.getAllPDF();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: AppColors.scaffoldColor));
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          CustomTextFields(
            textFieldController: vanchanScreenController.searchText,
            hintText: 'Search PDF by Name',
            leadingIcon: const Icon(Icons.search_sharp),
            onChange: (value) => vanchanScreenController.getAllPDF(
                queryParamSearch: value, queryParamLanguage: homeController.language[homeController.selectedLanguageIndex.value]),
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
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.52,
            child: Obx(
              () => !vanchanScreenController.isLoading.value
                  ? vanchanScreenController.allPDFListing.isNotEmpty
                      // ? GridView.builder(
                      //     shrinkWrap: true,
                      //     padding: const EdgeInsets.only(top: 18, left: 12, right: 12),
                      //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      //       crossAxisCount: 3,
                      //       // childAspectRatio: 1,
                      //       mainAxisExtent: 200, // fix height of child
                      //       crossAxisSpacing: 30,
                      //       mainAxisSpacing: 15, //vertical gap
                      //     ),
                      //     itemCount: vanchanScreenController.allPDFListing.length,
                      //     itemBuilder: (context, index) {
                      //       var pdfData = vanchanScreenController.allPDFListing;
                      //       return InkWell(
                      //         onTap: () {
                      //           print('(((((((((((   ${pdfData[index].lastPage}');
                      //           Get.to(() => PDFViewerFromUrl(
                      //                 url: 'https://gm-files.blr1.cdn.digitaloceanspaces.com/pdfs/${pdfData[index].fileName}',
                      //                 id: pdfData[index].sId ?? '',
                      //                 lastPage: pdfData[index].lastPage ?? 0,
                      //               ));
                      //         },
                      //         // color: Colors.red,
                      //         child: Column(
                      //           children: [
                      //             Container(
                      //               height: 120,
                      //               width: 100,
                      //               decoration: BoxDecoration(
                      //                 color: AppColors.grey3,
                      //                 borderRadius: BorderRadius.circular(20),
                      //                 image: DecorationImage(
                      //                   image: NetworkImage(
                      //                     'https://gm-files.blr1.cdn.digitaloceanspaces.com/images/${pdfData[index].image}',
                      //                   ),
                      //                   fit: BoxFit.fill,
                      //                 ),
                      //               ),
                      //             ),
                      //             Text(
                      //               '${pdfData[index].fileName}',
                      //               style: appTextStyle.montserrat12W500,
                      //             ),
                      //             // Text('${pdfData[index].language}'),
                      //             Text(
                      //               pdfData[index].description ?? '',
                      //               maxLines: 2,
                      //               overflow: TextOverflow.ellipsis,
                      //               style: appTextStyle.montserrat10W500Grey,
                      //             ),
                      //           ],
                      //         ),
                      //       );
                      //     },
                      //   )
                      ? ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: EdgeInsets.symmetric(vertical: 8),
                          itemCount: vanchanScreenController.allPDFListing.length,
                          itemBuilder: (context, index) {
                            var pdfData = vanchanScreenController.allPDFListing;
                            return Card(
                              margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
                              child: ListTile(
                                onTap: () {
                                  print('(((((((((((   ${pdfData[index].lastPage}');
                                  Get.to(() => PDFViewerFromUrl(
                                        url: 'https://gm-files.blr1.cdn.digitaloceanspaces.com/pdfs/${pdfData[index].fileName}',
                                        id: pdfData[index].sId ?? '',
                                        lastPage: pdfData[index].lastPage ?? 0,
                                        title: pdfData[index].fileName ?? '',
                                      ));
                                },
                                contentPadding: const EdgeInsets.all(8),

                                leading: Container(
                                  height: 180,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    // color: AppColors.grey3,
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        'https://gm-files.blr1.cdn.digitaloceanspaces.com/images/${pdfData[index].image}',
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                title: Text(
                                  '${pdfData[index].fileName}',
                                  style: appTextStyle.montserrat16,
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('${pdfData[index].language}'),
                                    Text(
                                      pdfData[index].description ?? '',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: appTextStyle.montserrat10W500Grey,
                                    ),
                                  ],
                                ),
                                // isThreeLine: true,
                              ),
                            );
                          },
                        )
                      : Center(child: Text('No PDF found'.tr))
                  : CustomWidgets.loader,
            ),
          ),
        ],
      ),
    );
  }
}
