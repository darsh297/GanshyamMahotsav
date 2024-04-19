import 'package:flutter/material.dart';

///User data list

class UserDataWidget extends StatefulWidget {
  @override
  _UserDataWidgetState createState() => _UserDataWidgetState();
}

class _UserDataWidgetState extends State<UserDataWidget> {
  List<Map<String, dynamic>> userDataList = [];

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
      appBar: AppBar(
        title: Text('User Data List'),
      ),
      body: userDataList.isNotEmpty
          ? ListView.builder(
              itemCount: userDataList.length,
              itemBuilder: (context, index) {
                final userData = userDataList[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Card(
                    elevation: 4,
                    child: ListTile(
                      leading: CircleAvatar(
                        // You can set user profile images here
                        child: Icon(Icons.person),
                      ),
                      title: Text(userData['username']),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Mobile: ${userData['mobile']}'),
                          Text('Credits: ${userData['credits']}'),
                        ],
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          // Handle edit action for this user
                          print('Edit user ${userData['username']}');
                        },
                      ),
                      onTap: () {
                        // Handle tap action for this user
                        print('View details for user ${userData['username']}');
                      },
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
