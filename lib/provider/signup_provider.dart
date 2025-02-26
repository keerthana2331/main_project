import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignupProvider with ChangeNotifier {
  String _email = '';
  String _password = '';
  String _name = '';
  bool _isLoading = false;
  bool _obscurePassword = true;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

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
    return _email.isNotEmpty &&
        _password.length >= 6 &&
        _name.isNotEmpty &&
        isEmailValid();
  }

  // Signup function
  Future<String?> signup() async {
    if (!isFormValid()) return "Invalid form data.";

    _isLoading = true;
    notifyListeners();

    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: _email,
        password: _password,
      );

      User? user = userCredential.user;
      if (user != null) {
        await user.sendEmailVerification();
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'name': _name,
          'email': _email,
          'createdAt': DateTime.now(),
          'emailVerified': false,
        });
      }
      return null; // Success
    } catch (e) {
      return e.toString(); // Return error message
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Google sign-in
  Future<String?> signUpWithGoogle() async {
    _isLoading = true;
    notifyListeners();

    try {
      await _auth.signOut();
      await _googleSignIn.signOut();

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        _isLoading = false;
        notifyListeners();
        return "Google sign-in cancelled.";
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        final userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (!userDoc.exists) {
          await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
            'name': googleUser.displayName ?? '',
            'email': googleUser.email,
            'createdAt': DateTime.now(),
            'signInMethod': 'google',
          });
        }
      }
      return null; // Success
    } catch (e) {
      return "Google Sign-In Error: $e";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Clear form
  void clearForm() {
    _email = '';
    _password = '';
    _name = '';
    notifyListeners();
  }
}
