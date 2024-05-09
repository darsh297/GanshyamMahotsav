// Define the time duration in minutes to read each page

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:get/get.dart';
import 'package:ghanshyam_mahotsav/network/api_config.dart';
import 'package:ghanshyam_mahotsav/utils/app_text_styles.dart';

import '../utils/app_colors.dart';

const double timeToReadPerPage = 1.0;

class PDFViewerFromUrl extends StatefulWidget {
  const PDFViewerFromUrl({super.key, required this.url, required this.id, required this.title, this.lastPage});

  final String url;
  final String id;
  final String title;
  final int? lastPage;

  @override
  State<PDFViewerFromUrl> createState() => _PDFViewerFromUrlState();
}

class _PDFViewerFromUrlState extends State<PDFViewerFromUrl> {
  // int _totalPages = 0;

  int _currentPage = 0;
  // double _progress = 0.0;
  // bool _isScrollComplete = false;
  // RxBool pageSwap = false.obs;
  final ApiBaseHelper apiBaseHelper = ApiBaseHelper();
  final AppTextStyle appTextStyle = AppTextStyle();
  // late Timer _timer;

  @override
  void initState() {
    // startTimer();
    print('===================================${widget.lastPage}');
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: AppColors.scaffoldColor));
    super.initState();
  }

  // void startTimer() {
  //   // Set up a timer for 5 minutes
  //   _timer = Timer(const Duration(seconds: 5), () {
  //     pageSwap.value = true;
  //     print('1111111111${pageSwap.value}');
  //   });
  // }

  @override
  void dispose() {
    storeLastPage();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: AppColors.scaffoldColor));

    super.dispose();
  }

  storeLastPage() async {
    await apiBaseHelper.getData(leadAPI: 'pdf/lastPage/${widget.id}/$_currentPage');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.white),
          onPressed: () => Get.back(),
        ),
        title: Text(
          widget.title,
          style: appTextStyle.montserrat14W600White,
        ),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body:

          // Stack(
          //   alignment: Alignment.center,
          //   children: [
          Container(
        height: Get.height,
        width: Get.width,
        // color: Colors.red,
        alignment: Alignment.center,
        // padding: EdgeInsets.all(30),
        // margin: EdgeInsets.all(20),
        child: Scrollbar(
          child: PDF(
              fitEachPage: false,
              defaultPage: widget.lastPage ?? 0,
              onPageChanged: (int? page, int? totalPages) {
                _currentPage = page ?? 0 + 1;
                print('||| $_currentPage ${widget.id}');
              }
              //   print('=================================${pageSwap.value}');
              //   if (pageSwap.value) {
              //     pageSwap.value = false;
              //     startTimer();
              //     debugPrint('PDF view $_isScrollComplete $_currentPage $_totalPages ');
              //     setState(() {
              //       _currentPage = page ?? 0 + 1; // Adding 1 because page numbering starts from 0
              //       _totalPages = (totalPages ?? 1) - 1;
              //       if (!_isScrollComplete) {
              //         _progress = (_currentPage / _totalPages) * 100; // Calculate progress based on current page and total pages
              //         // Ensure progress is 100% when scrolled to the last page
              //         if (_currentPage == _totalPages) {
              //           _progress = 100.0;
              //           _isScrollComplete = true; // Mark scroll as complete
              //         }
              //       }
              //     });
              //   }

              ).fromUrl(
            widget.url,
          ),
        ),
      ),

      // Positioned(
      //   bottom: 20.0,
      //   child: Text(
      //     'Progress: ${_progress.toStringAsFixed(2)}%',
      //     style: const TextStyle(fontSize: 20.0),
      //   ),
      // ),
      //   ],
      // ),
    );
  }
}
