import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ghanshyam_mahotsav/network/api_config.dart';
import 'package:ghanshyam_mahotsav/utils/app_text_styles.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Add shared_preferences import
import '../utils/app_colors.dart';
import 'package:flutter/cupertino.dart';

const double timeToReadPerPage = 1.0;

class PDFViewerFromUrl extends StatefulWidget {
  const PDFViewerFromUrl({
    super.key,
    required this.id,
    required this.title,
    this.lastPage,
    required this.contents,
  });

  final String contents;
  final String id;
  final String title;
  final int? lastPage;

  @override
  State<PDFViewerFromUrl> createState() => _PDFViewerFromUrlState();
}

class _PDFViewerFromUrlState extends State<PDFViewerFromUrl> {
  int _currentPage = 0;
  double _fontSize = 14.0; // Default font size
  double _tempFontSize = 14.0; // Temp font size for dialog
  final ApiBaseHelper apiBaseHelper = ApiBaseHelper();
  final AppTextStyle appTextStyle = AppTextStyle();
  FixedExtentScrollController? _scrollController; // Add scroll controller

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: AppColors.scaffoldColor));
    _loadFontSize(); // Load the saved font size when the screen is initialized
  }

  @override
  void dispose() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: AppColors.scaffoldColor));
    _scrollController?.dispose(); // Dispose the scroll controller
    super.dispose();
  }

  // Load saved font size from shared preferences
  Future<void> _loadFontSize() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      log("size is aa.........................${prefs.getDouble('fontSize')}");
      _fontSize = prefs.getDouble('fontSize') ?? 14.0; // Default to 14.0 if not found
      _tempFontSize = _fontSize;

      // Corrected the calculation of the initialItem based on the current font size
      int initialItem = (_fontSize - 10).toInt();
      _scrollController = FixedExtentScrollController(initialItem: initialItem);
    });
  }

  // Save the current font size to shared preferences
  Future<void> _saveFontSize(double fontSize) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setDouble('fontSize', fontSize);
  }

  Future<void> storeLastPage() async {
    await apiBaseHelper.getData(leadAPI: 'pdf/lastPage/${widget.id}/$_currentPage');
  }

  void _showFontSizeDialog() {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text('Adjust Font Size', style: appTextStyle.montserratDynamicBlack(_fontSize)),
          content: SizedBox(
            height: 80,
            child: CupertinoPicker(
              scrollController: _scrollController, // Use the scroll controller here
              itemExtent: 40.0,
              onSelectedItemChanged: (int index) {
                setState(() {
                  _tempFontSize = 10.0 + index.toDouble(); // Adjust for the correct font size
                });
              },
              children: List<Widget>.generate(
                21, // number of items in the picker (10.0 to 30.0)
                    (int index) {
                  double fontSize = 10.0 + index.toDouble();
                  return Center(
                    child: Text(
                      fontSize.toStringAsFixed(1),
                      style: appTextStyle.montserratDynamicBlack(fontSize),
                    ),
                  );
                },
              ),
            ),
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              onPressed: () {
                setState(() {
                  _fontSize = _tempFontSize; // Update the font size immediately
                });
                _saveFontSize(_fontSize); // Save the font size when the user confirms
                _loadFontSize();
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('OK', style: appTextStyle.montserratDynamicBlack(_fontSize)),
            ),
            CupertinoDialogAction(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog without making changes
              },
              child: Text('Cancel', style: appTextStyle.montserratDynamicBlack(_fontSize)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEF9C66),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: AppColors.white),
          onPressed: () => Get.back(),
        ),
        title: Text(
          widget.title,
          style: appTextStyle.montserratDynamicWhite(_fontSize),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.text_fields, color: AppColors.white),
            onPressed: _showFontSizeDialog,
          ),
        ],
        backgroundColor: Colors.transparent,
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: Container(
        height: Get.height,
        width: Get.width,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 30),
        child: Align(
          alignment: Alignment.centerRight,
          child: Scrollbar(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                widget.contents,
                style: appTextStyle.montserratDynamicWhite(_fontSize), // Apply the updated font size here
              ),
            ),
          ),
        ),
      ),
    );
  }
}
