import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// SignupProvider to handle form data and validation
class SignupProvider with ChangeNotifier {
  String _email = '';
  String _password = '';
  String _name = '';
  bool _isLoading = false;
  bool _obscurePassword = true;

  // Getters
  String get email => _email;
  String get password => _password;
  String get name => _name;
  bool get isLoading => _isLoading;
  bool get obscurePassword => _obscurePassword;

  // Setters
  void setEmail(String value) {
    _email = value;
    notifyListeners();
  }

  void setPassword(String value) {
    _password = value;
    notifyListeners();
  }

  void setName(String value) {
    _name = value;
    notifyListeners();
  }

  void togglePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  // Email validation
  bool isEmailValid() {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(_email);
  }

  // Form validation
  bool isFormValid() {
    return _email.isNotEmpty && _password.length >= 6 && _name.isNotEmpty && isEmailValid();
  }

  // Signup function
  Future<bool> signup() async {
    if (!isFormValid()) return false;

    _isLoading = true;
    notifyListeners();

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));
    
    // In a real app, you would integrate with your authentication service here
    
    _isLoading = false;
    notifyListeners();
    
    return true; // Return success status
  }

  // Clear form
  void clearForm() {
    _email = '';
    _password = '';
    _name = '';
    notifyListeners();
  }
}