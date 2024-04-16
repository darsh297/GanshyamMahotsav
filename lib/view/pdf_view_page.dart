import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PDFViewerPage extends StatefulWidget {
  @override
  _PDFViewerPageState createState() => _PDFViewerPageState();
}

class _PDFViewerPageState extends State<PDFViewerPage> {
  // PDF link
  final String pdfUrl = 'https://example.com/sample.pdf';

  // Current page index
  int currentPage = 0;

  // Total number of pages in the PDF
  int totalPageCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Viewer'),
      ),
      body: Column(
        children: [
          // PDF viewer
          Expanded(
            child: PDFView(
              filePath: pdfUrl,
              onPageChanged: (int? page, int? page2) {
                setState(() {
                  currentPage = page!;
                });
              },
              onViewCreated: (PDFViewController controller) async {
                totalPageCount = (await controller.getPageCount())!;
                setState(() {});
              },
            ),
          ),
          // Progress indicator
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Reading Progress: ${((currentPage + 1) / totalPageCount * 100).toStringAsFixed(2)}%',
              style: TextStyle(fontSize: 16.0),
            ),
          ),
        ],
      ),
    );
  }
}
