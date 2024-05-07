// Define the time duration in minutes to read each page
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:get/get.dart';
import 'package:ghanshyam_mahotsav/network/api_config.dart';

const double timeToReadPerPage = 1.0;

class PDFViewerFromUrl extends StatefulWidget {
  const PDFViewerFromUrl({super.key, required this.url, required this.id});

  final String url;
  final String id;

  @override
  State<PDFViewerFromUrl> createState() => _PDFViewerFromUrlState();
}

class _PDFViewerFromUrlState extends State<PDFViewerFromUrl> {
  int _totalPages = 0;
  int _currentPage = 0;
  double _progress = 0.0;
  bool _isScrollComplete = false;
  RxBool pageSwap = false.obs;
  final ApiBaseHelper apiBaseHelper = ApiBaseHelper();
  late Timer _timer;

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  void startTimer() {
    // Set up a timer for 5 minutes
    _timer = Timer(const Duration(seconds: 5), () {
      pageSwap.value = true;
      print('1111111111${pageSwap.value}');
    });
  }

  @override
  void dispose() {
    storeLastPage();
    super.dispose();
  }

  storeLastPage() async {
    var apiRes = await apiBaseHelper.getData(leadAPI: 'pdf/lastPage/${widget.id}/$_currentPage');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Obx(
            () => PDF(
              // defaultPage: 1,
              enableSwipe: pageSwap.value,
              onPageChanged: (int? page, int? totalPages) {
                print('=================================${pageSwap.value}');
                if (pageSwap.value) {
                  pageSwap.value = false;
                  startTimer();
                  debugPrint('PDF view $_isScrollComplete $_currentPage $_totalPages ');
                  setState(() {
                    _currentPage = page ?? 0 + 1; // Adding 1 because page numbering starts from 0
                    _totalPages = (totalPages ?? 1) - 1;
                    if (!_isScrollComplete) {
                      _progress = (_currentPage / _totalPages) * 100; // Calculate progress based on current page and total pages
                      // Ensure progress is 100% when scrolled to the last page
                      if (_currentPage == _totalPages) {
                        _progress = 100.0;
                        _isScrollComplete = true; // Mark scroll as complete
                      }
                    }
                  });
                }
              },
              onError: (dynamic error) {},
            ).fromUrl(widget.url),
          ),
          Positioned(
            bottom: 20.0,
            child: Text(
              'Progress: ${_progress.toStringAsFixed(2)}%',
              style: const TextStyle(fontSize: 20.0),
            ),
          ),
        ],
      ),
    );
  }
}
