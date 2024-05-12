import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceClass {
  void storeData(String key, dynamic value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    if (value is String) {
      await prefs.setString(key, value);
    } else if (value is int) {
      await prefs.setInt(key, value);
    } else if (value is double) {
      await prefs.setDouble(key, value);
    } else if (value is bool) {
      await prefs.setBool(key, value);
    }
  }

  /// Retrieve a value
  Future<dynamic> retrieveData(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('frrrrrrrooooommmm  retrivedata ${prefs.get(key)}');
    return prefs.get(key);
  }

  /// Remove a value
  void removeData(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  Future<bool> retrieveBool(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key) ?? false;
  }

  void storeBool(String key, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  void removeAllData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  // Increment the value stored in shared preferences
  Future<void> incrementCredit(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int currentCredit = prefs.getInt(key) ?? 0; // Get current credit, default to 0 if not found
    int incrementedCredit = currentCredit + 1; // Increment the credit
    await prefs.setInt(key, incrementedCredit); // Store the incremented value back
  }
}
