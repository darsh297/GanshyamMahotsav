import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:ghanshyam_mahotsav/utils/app_colors.dart';

class PDFViewerFromUrl extends StatefulWidget {
  const PDFViewerFromUrl({Key? key, required this.url}) : super(key: key);

  final String url;

  @override
  State<PDFViewerFromUrl> createState() => _PDFViewerFromUrlState();
}

class _PDFViewerFromUrlState extends State<PDFViewerFromUrl> {
  // @override
  int _totalPages = 0;

  int _currentPage = 0;

  double _progress = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: AppBar(
        title: const Text('Gyan Vanchan'),
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          PDF(
            onPageChanged: (int? page, int? totalPages) {
              setState(() {
                _currentPage = page ?? 0 + 1; // Adding 1 because page numbering starts from 0
                _totalPages = totalPages ?? 0;
                _progress = (_currentPage / _totalPages) * 100;
              });
            },
            onError: (dynamic error) {
              print('Error: $error');
            },
          ).fromUrl(widget.url),
          Text(
            'Progress: ${_progress.toStringAsFixed(2)}%',
            style: TextStyle(fontSize: 20.0),
          ),
        ],
      ),
    );
  }
}
