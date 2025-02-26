import 'package:flutter/material.dart';
import 'package:navigation_screens/provider/email_verification_provider.dart';
import 'package:navigation_screens/screens/screen1.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';



class EmailVerificationScreen extends StatelessWidget {
  const EmailVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => EmailVerificationProvider(),
      child: Consumer<EmailVerificationProvider>(
        builder: (context, provider, child) {
          final user = FirebaseAuth.instance.currentUser;

          return Scaffold(
            appBar: AppBar(title: const Text("Verify Email")),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.email, size: 80, color: Colors.blue),
                    const SizedBox(height: 20),
                    const Text(
                      "A verification email has been sent to your email address.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      user?.email ?? "",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    provider.isLoading
                        ? const CircularProgressIndicator()
                        : ElevatedButton(
                            onPressed: provider.resendVerificationEmail,
                            child: const Text("Resend Email"),
                          ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        await FirebaseAuth.instance.currentUser?.reload();
                        if (FirebaseAuth.instance.currentUser?.emailVerified ?? false) {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) => Screen1()),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Email not verified yet.")),
                          );
                        }
                      },
                      child: const Text("Check Verification"),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
