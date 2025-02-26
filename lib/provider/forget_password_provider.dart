// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ForgetPasswordProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController emailController = TextEditingController();

  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void setErrorMessage(String? message) {
    _errorMessage = message;
    notifyListeners();
  }

  Future<bool> resetPassword(BuildContext context) async {
    String email = emailController.text.trim().toLowerCase();

    if (!_isValidEmail(email)) {
      _showSnackBar(context, "Please enter a valid email address.");
      return false;
    }

    setLoading(true);
    setErrorMessage(null);

    try {
      QuerySnapshot userQuery = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: email)
          .get();

      if (userQuery.docs.isEmpty) {
        setErrorMessage("This email is not registered");
        _showSnackBar(context, "This email is not registered.");
        setLoading(false);
        return false;
      }

      await _auth.sendPasswordResetEmail(email: email);
      _showSnackBar(context, "Password reset link has been sent to your email.");
      print('Password reset email sent');
      setLoading(false);
      return true;
    } on FirebaseAuthException catch (e) {
      String errorMessage = _getFirebaseErrorMessage(e.code);
      setErrorMessage(errorMessage);
      _showSnackBar(context, errorMessage);
      setLoading(false);
      return false;
    } catch (e) {
      setErrorMessage("Unexpected error");
      _showSnackBar(context, "An unexpected error occurred. Please try again.");
      setLoading(false);
      return false;
    }
  }

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
    return emailRegex.hasMatch(email);
  }

  String _getFirebaseErrorMessage(String code) {
    switch (code) {
      case 'user-not-found':
        return "No user found with this email.";
      case 'invalid-email':
        return "Invalid email format.";
      case 'too-many-requests':
        return "Too many requests. Try again later.";
      default:
        return "Something went wrong. Please try again.";
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
}
