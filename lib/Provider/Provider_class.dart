import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:password_manager/Provider/Model_class.dart';
import 'package:http/http.dart' as http;
const String passwordBoxName = "passwordBox";

class PasswordProvider extends ChangeNotifier {
  final Box<PasswordEntry> _passwordBox = Hive.box(passwordBoxName);
  final Map<String, String?> appIcons = {};

  List<PasswordEntry> get passwords => _passwordBox.values.toList();

  void addPassword(PasswordEntry entry) {
    _passwordBox.add(entry);
    notifyListeners();
  }

  // Function to update existing entry
  void updatePassword(int key, String newUsername, String newPassword) {
    final existingEntry = _passwordBox.get(key);
    if (existingEntry != null) {
      _passwordBox.put(
        key,
        PasswordEntry(
          appName: existingEntry.appName,
          emailPhone: newUsername,
          password: newPassword,
          appIcon: existingEntry.appIcon,
          category: existingEntry.category,
        ),
      );
      notifyListeners();
    }
  }

  void deletePassword(int key) {
    _passwordBox.delete(key);
    notifyListeners();
  }
 
  Future<void> addApp(String appName) async {
    final response = await http.get(Uri.parse('https://logo.clearbit.com/$appName.com'));
    if (response.statusCode == 200) {
      appIcons[appName] = 'https://logo.clearbit.com/$appName.com';
    } else {
      appIcons[appName] = null; // No icon found
    }
    notifyListeners(); // Update the UI
  }
}
