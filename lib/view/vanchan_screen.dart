import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ghanshyam_mahotsav/utils/app_colors.dart';
import 'package:ghanshyam_mahotsav/view/pdf_view_page.dart';
import 'package:ghanshyam_mahotsav/widgets/custom_textfield.dart';

class VanchanScreen extends StatefulWidget {
  const VanchanScreen({super.key});

  @override
  State<VanchanScreen> createState() => _VanchanScreenState();
}

class _VanchanScreenState extends State<VanchanScreen> {
  String _selectedLanguage = 'English';
  final TextEditingController searchText = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: AppBar(
        //     actions: [
        //   Icon(Icons.search),
        //   Icon(Icons.filter_alt_sharp),
        //   DropdownButton<String>(
        //     value: _selectedLanguage,
        //     onChanged: (String? newValue) {
        //       setState(() {
        //         _selectedLanguage = newValue ?? '';
        //       });
        //     },
        //     items: <String>[
        //       'English',
        //       'Gujarati',
        //     ].map<DropdownMenuItem<String>>((String value) {
        //       return DropdownMenuItem<String>(
        //         value: value,
        //         child: Text(value),
        //       );
        //     }).toList(),
        //   ),
        //   SizedBox(width: 20),
        // ],
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: CustomTextFields(
                    textFieldController: searchText,
                    hintText: 'Search PDF by Name',
                    leadingIcon: const Icon(Icons.search_sharp),
                    inputBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.white)),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 8),
                  decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(8)),
                  child: PopupMenuButton<String>(
                    // color: AppColors.white,
                    // surfaceTintColor: AppColors.white,

                    icon: const Icon(Icons.language), // Set the icon
                    onSelected: (value) {
                      setState(() {
                        _selectedLanguage = value;
                      });
                    },
                    itemBuilder: (BuildContext context) {
                      return ['English', 'Spanish', 'French'].map((String language) {
                        return PopupMenuItem<String>(
                          value: language,
                          child: Text(language),
                        );
                      }).toList();
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: ListTile(
                    onTap: () => Get.to(() => PDFViewerPage()),
                    contentPadding: const EdgeInsets.all(10),
                    leading: const SizedBox(
                      height: 50,
                      width: 40,
                      child: Icon(Icons.picture_as_pdf),
                    ),
                    title: Text('PDF Name - $index'),
                    subtitle: Text('Language $index'),
                  ),
                );
              },
              itemCount: 2,
            ),
          ],
        ),
      ),
    );
  }
}
