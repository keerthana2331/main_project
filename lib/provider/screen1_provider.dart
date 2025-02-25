import 'package:flutter/material.dart';
import 'package:navigation_screens/screens/screen2.dart';
import 'package:navigation_screens/screens/loginscreen.dart';

// Theme option model
class ThemeOption {
  final String name;
  final Color primaryColor;
  final Color accentColor;

  ThemeOption({
    required this.name,
    required this.primaryColor,
    required this.accentColor,
  });
}

// Theme provider class
class ThemeProvider with ChangeNotifier {
  ThemeOption _currentTheme = ThemeOption(
    name: "Ocean Blue",
    primaryColor: Color(0xFF1A2980),
    accentColor: Color(0xFF26D0CE),
  );

  ThemeOption get currentTheme => _currentTheme;

  void setTheme(ThemeOption theme) {
    _currentTheme = theme;
    notifyListeners();
  }
  
  // Helper method to get ThemeData
  ThemeData getThemeData() {
    return ThemeData(
      primaryColor: _currentTheme.primaryColor,
      colorScheme: ColorScheme.fromSeed(
        seedColor: _currentTheme.primaryColor,
        secondary: _currentTheme.accentColor,
      ),
      useMaterial3: true,
    );
  }
}

// Navigation provider
class Screen1Provider extends ChangeNotifier {
  void navigateToScreen2(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Screen2()),
    );
  }
  
  void navigateToLogin(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }
}