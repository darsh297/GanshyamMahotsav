// import 'package:shared_preferences/shared_preferences.dart';
//
// class SharedPreferenceClass {
//   void storeData(String key, dynamic value) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     if (value is String) {
//       await prefs.setString(key, value);
//     } else if (value is int) {
//       await prefs.setInt(key, value);
//     } else if (value is double) {
//       await prefs.setDouble(key, value);
//     } else if (value is bool) {
//       await prefs.setBool(key, value);
//     }
//   }
//
// // Retrieve a value
//   Future<dynamic> retrieveData(String key) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.get(key);
//   }
//
// // Remove a value
//   void removeData(String key) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.remove(key);
//   }
// }
