import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:navigation_screens/screens/screen2.dart';

class LoginProvider extends ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final String correctEmail = 'testuser@chatapp.com';
  final String correctPassword = 'ChatApp123!';

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void login(BuildContext context) {
    String email = emailController.text;
    String password = passwordController.text;

    _isLoading = true;
    notifyListeners();

    Future.delayed(const Duration(seconds: 1), () {
      if (email == correctEmail && password == correctPassword) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Screen2()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid email or password')),
        );
      }
      _isLoading = false;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}