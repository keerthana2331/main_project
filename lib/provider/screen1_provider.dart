import 'package:flutter/material.dart';
import 'package:navigation_screens/screens/screen2.dart';
import 'package:navigation_screens/screens/loginscreen.dart';

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
