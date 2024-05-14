import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ghanshyam_mahotsav/controller/home_controller.dart';
import 'package:ghanshyam_mahotsav/controller/vanchan_screen_controller.dart';
import 'package:ghanshyam_mahotsav/utils/app_colors.dart';
import 'package:ghanshyam_mahotsav/utils/app_text_styles.dart';
import 'package:ghanshyam_mahotsav/view/pdf_view_page.dart';
import 'package:ghanshyam_mahotsav/widgets/custom_textfield.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

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
    vanchanScreenController.adminData();
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
            textInputAction: TextInputAction.search,
            onSubmitted: (value) {
              if (!vanchanScreenController.isLoading.value) {
                vanchanScreenController.getAllPDF(
                    queryParamSearch: value, queryParamLanguage: homeController.language[homeController.selectedLanguageIndex.value]);
                // pageNumber = 1;
                // myAgentController.allDataReceived.value = false;
                // myAgentController.myAgentList.value = <MyAgentModel>[].obs;
                // myAgentController.isLoading.value = true;
                // myAgentController.agentListing(searchText: value.trim(), pageNumber: pageNumber);
              }
            },
            inputBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.white)),
            trailingIcon: IconButton(
                icon: const Icon(Icons.cancel),
                onPressed: () {
                  if (vanchanScreenController.searchText.text != '') {
                    vanchanScreenController.getAllPDF(queryParamLanguage: homeController.language[homeController.selectedLanguageIndex.value]);
                    vanchanScreenController.searchText.text = '';
                  }
                }),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.52,
            child: Obx(
              () => !vanchanScreenController.isLoading.value
                  ? vanchanScreenController.allPDFListing.isNotEmpty
                      ? ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          itemCount: vanchanScreenController.allPDFListing.length,
                          itemBuilder: (context, index) {
                            var pdfData = vanchanScreenController.allPDFListing;
                            return Card(
                              margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
                              child: ListTile(
                                onTap: () {
                                  Get.to(() => PDFViewerFromUrl(
                                        url: 'https://gm-files.blr1.cdn.digitaloceanspaces.com/pdfs/${pdfData[index].fileName}',
                                        id: pdfData[index].sId ?? '',
                                        lastPage: pdfData[index].lastPage ?? 0,
                                        title: pdfData[index].fileName ?? '',
                                      ));
                                  // ?.then((value) => vanchanScreenController.getAllPDF());
                                },
                                contentPadding: const EdgeInsets.all(8),
                                title: Row(
                                  children: [
                                    Container(
                                      height: 100,
                                      width: 70,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            'https://gm-files.blr1.cdn.digitaloceanspaces.com/images/${pdfData[index].image}',
                                          ),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    Expanded(
                                      child: SizedBox(
                                        // color: Colors.red,
                                        height: 100,
                                        // width: 70,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    pdfData[index].fileName ?? '',
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: appTextStyle.montserrat12W500,
                                                  ),
                                                  Text(
                                                    pdfData[index].description ?? '',
                                                    maxLines: 6,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: appTextStyle.montserrat10W500Grey,
                                                  ),
                                                  Text(
                                                    '${pdfData[index].language}',
                                                    style: appTextStyle.montserrat8W500,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            vanchanScreenController.isAdmin.value
                                                ? Align(
                                                    alignment: Alignment.bottomRight,
                                                    child: IconButton(
                                                        onPressed: () {
                                                          showDialog(
                                                            barrierDismissible: false,
                                                            context: context,
                                                            builder: (BuildContext context) {
                                                              return AlertDialog(
                                                                title: Text('Delete Book'.tr),
                                                                content: Text('Are you sure want to delete book?'.tr),
                                                                actions: [
                                                                  TextButton(
                                                                    onPressed: () => Get.back(),
                                                                    child: Text('No'.tr),
                                                                  ),
                                                                  Obx(
                                                                    () => TextButton(
                                                                      onPressed: () {
                                                                        vanchanScreenController.deleteBook(pdfData[index].sId, index);
                                                                      },
                                                                      child: vanchanScreenController.deleteBookLoading.value
                                                                          ? LoadingAnimationWidget.threeArchedCircle(
                                                                              color: AppColors.primaryColor, size: 20)
                                                                          : Text('Yes'.tr),
                                                                    ),
                                                                  ),
                                                                ],
                                                              );
                                                            },
                                                          );
                                                        },
                                                        icon: const Icon(Icons.delete_forever_outlined)))
                                                : const SizedBox()
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
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
