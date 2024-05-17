// Define the time duration in minutes to read each page

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:get/get.dart';
import 'package:ghanshyam_mahotsav/network/api_config.dart';
import 'package:ghanshyam_mahotsav/utils/app_text_styles.dart';

// import 'package:pdf_text/pdf_text.dart';
import '../utils/app_colors.dart';

const double timeToReadPerPage = 1.0;

class PDFViewerFromUrl extends StatefulWidget {
  const PDFViewerFromUrl({super.key, required this.id, required this.title, this.lastPage, required this.contents});

  // final String url;
  final String contents;
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
    print('===================================${widget.lastPage}');
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: AppColors.scaffoldColor));
    super.initState();
  }

  @override
  void dispose() {
    // storeLastPage();
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
        padding: EdgeInsets.symmetric(vertical: 30),
        child: Align(
          alignment: Alignment.centerRight,
          child: Scrollbar(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                widget.contents,
                style: appTextStyle.montserrat14W600White,
                textAlign: TextAlign.center,
              ),
            ),
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
// import 'package:flutter/material.dart';
// import 'package:flutter_pdfview/flutter_pdfview.dart';
//
// class PDFViewerPage extends StatefulWidget {
//   @override
//   _PDFViewerPageState createState() => _PDFViewerPageState();
// }
//
// class _PDFViewerPageState extends State<PDFViewerPage> {
//   // PDF link
//   final String pdfUrl = 'http://www.pdf995.com/samples/pdf.pdf';
//
//   // Current page index
//   int currentPage = 0;
//
//   // Total number of pages in the PDF
//   int totalPageCount = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('PDF Viewer'),
//       ),
//       body: Column(
//         children: [
//           // PDF viewer
//           Expanded(
//             child: PDFView(
//               filePath: pdfUrl,
//               onPageChanged: (int? page, int? page2) {
//                 setState(() {
//                   currentPage = page!;
//                 });
//               },
//               onError: (error) {
//                 print('Error loading PDF: $error');
//               },
//               onViewCreated: (PDFViewController controller) async {
//                 totalPageCount = (await controller.getPageCount())!;
//                 setState(() {});
//               },
//             ),
//           ),
//           // Progress indicator
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(
//               'Reading Progress: ${((currentPage + 1) / totalPageCount * 100).toStringAsFixed(2)}%',
//               style: TextStyle(fontSize: 16.0),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
