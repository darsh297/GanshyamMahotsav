import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ghanshyam_mahotsav/utils/app_colors.dart';

///User data list

class UserDataWidget extends StatefulWidget {
  const UserDataWidget({super.key});

  @override
  _UserDataWidgetState createState() => _UserDataWidgetState();
}

class _UserDataWidgetState extends State<UserDataWidget> {
  List<Map<String, dynamic>> userDataList = [];
  RxBool isExpanded = true.obs;
  @override
  void initState() {
    super.initState();
    // Assume fetchUserDataList() fetches a list of user data from the API
    fetchUserDataList().then((dataList) {
      setState(() {
        userDataList = dataList;
      });
    }).catchError((error) {
      print('Error fetching user data: $error');
    });
  }

  Future<List<Map<String, dynamic>>> fetchUserDataList() async {
    // Fetch user data list from API
    return [
      {'username': 'User 1', 'mobile': '1234567890', 'credits': 100},
      {'username': 'User 2', 'mobile': '9876543210', 'credits': 200},
      // Add more user data as needed
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldColor,
      appBar: AppBar(
        title: Text('User Data List'),
      ),
      body: userDataList.isNotEmpty
          ? ListView.builder(
              itemCount: userDataList.length,
              itemBuilder: (context, index) {
                final userData = userDataList[index];
                bool isExpanded = false; // Variable to track if the details are expanded
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Card(
                    elevation: 4,
                    child: Column(
                      children: [
                        ListTile(
                          leading: const CircleAvatar(
                            // You can set user profile images here
                            child: Icon(Icons.person),
                          ),
                          title: Text(userData['username']),
                          subtitle: Text('Mobile: ${userData['mobile']}'),
                          onTap: () {
                            // Toggle the expansion state
                            setState(() {
                              isExpanded = !isExpanded;
                            });
                          },
                        ),
                        // Show credits only when the tile is tapped (expanded)
                        if (isExpanded)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text('Date: ${userData['credits']}'),
                                    Text('Credits: ${userData['credits']}'),
                                  ],
                                ),
                                // Add more details here if needed
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
