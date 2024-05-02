// Define the time duration in minutes to read each page
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

const double timeToReadPerPage = 1.0;

class PDFViewerFromUrl extends StatefulWidget {
  const PDFViewerFromUrl({super.key, required this.url});

  final String url;

  @override
  State<PDFViewerFromUrl> createState() => _PDFViewerFromUrlState();
}

class _PDFViewerFromUrlState extends State<PDFViewerFromUrl> {
  int _totalPages = 0;
  int _currentPage = 0;
  double _progress = 0.0;
  bool _isScrollComplete = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          PDF(
            defaultPage: 1,

            // enableSwipe: true,
            // nightMode: true,
            // onPageChanged: (int? page, int? totalPages) {
            //   setState(() {
            //     _currentPage = page ?? 0 + 1; // Adding 1 because page numbering starts from 0
            //     _totalPages = (totalPages ?? 1) - 1;
            //     if (!_isScrollComplete) {
            //       _progress = (_currentPage / _totalPages) * 100; // Calculate progress based on current page and total pages
            //       // Ensure progress is 100% when scrolled to the last page
            //       if (_currentPage == _totalPages) {
            //         _progress = 100.0;
            //         _isScrollComplete = true; // Mark scroll as complete
            //       }
            //     }
            //   });
            // },
            onError: (dynamic error) {},
          ).fromUrl(widget.url),
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
