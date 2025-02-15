import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:password_manager/Provider/Model_class.dart';

const String passwordBoxName = "passwordBox";

class PasswordProvider extends ChangeNotifier {
  final Box<PasswordEntry> _passwordBox = Hive.box(passwordBoxName);

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
        appName: existingEntry.appName, // Preserve appName from the existing entry
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
  _passwordBox.delete(key); // Delete from Hive
  notifyListeners(); // Refresh UI
}


}