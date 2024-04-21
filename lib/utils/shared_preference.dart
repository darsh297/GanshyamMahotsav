import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceClass {
  void storeData(String key, dynamic value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    print('||||$key $value');
    if (value is String) {
      print('1111$key $value');

      await prefs.setString(key, value);
    } else if (value is int) {
      print('2222$key $value');

      await prefs.setInt(key, value);
    } else if (value is double) {
      print('333$key $value');

      await prefs.setDouble(key, value);
    } else if (value is bool) {
      print('444$key $value');

      await prefs.setBool(key, value);
    }
  }

  /// Retrieve a value
  Future<dynamic> retrieveData(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
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

  // Increment the value stored in shared preferences
  Future<void> incrementCredit(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int currentCredit = prefs.getInt(key) ?? 0; // Get current credit, default to 0 if not found
    int incrementedCredit = currentCredit + 1; // Increment the credit
    await prefs.setInt(key, incrementedCredit); // Store the incremented value back
  }
}
