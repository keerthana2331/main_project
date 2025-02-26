// ignore_for_file: avoid_print

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EmailVerificationProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Timer? _timer;
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  EmailVerificationProvider() {
    startVerificationCheck();
  }

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void startVerificationCheck() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) async {
      await checkEmailVerification();
    });
  }

  Future<void> checkEmailVerification() async {
    User? user = _auth.currentUser;
    if (user == null) return;

    await user.reload();
    user = _auth.currentUser;

    if (user != null && user.emailVerified) {
      _timer?.cancel();

      // Update Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update({'emailVerified': true});

      notifyListeners();
    }
  }

  Future<void> resendVerificationEmail() async {
    setLoading(true);
    try {
      User? user = _auth.currentUser;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
      }
    } finally {
      setLoading(false);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
