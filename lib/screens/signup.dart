// Signup page UI (Stateless widget)
import 'package:flutter/material.dart';
import 'package:navigation_screens/main.dart';
import 'package:navigation_screens/provider/signup_provider.dart';
import 'package:navigation_screens/screens/loginscreen.dart';

import 'package:provider/provider.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Access theme
    final themeProvider = Provider.of<ThemeProvider>(context);
    
    return ChangeNotifierProvider(
      create: (context) => SignupProvider(),
      child: Consumer<SignupProvider>(
        builder: (context, signupProvider, _) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: themeProvider.currentTheme.primaryColor,
              title: const Text(
                'Create Account',
                style: TextStyle(color: Colors.white),
              ),
              centerTitle: true,
              elevation: 0,
            ),
            body: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    themeProvider.currentTheme.primaryColor,
                    themeProvider.currentTheme.accentColor,
                  ],
                ),
              ),
              child: SafeArea(
                child: Center(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Card(
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // App Logo or Icon
                              CircleAvatar(
                                radius: 40,
                                backgroundColor: themeProvider.currentTheme.accentColor.withOpacity(0.2),
                                child: Icon(
                                  Icons.person_add,
                                  size: 40,
                                  color: themeProvider.currentTheme.primaryColor,
                                ),
                              ),
                              const SizedBox(height: 24),
                              
                              // Title
                              Text(
                                'Join Us',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: themeProvider.currentTheme.primaryColor,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Create your account to get started',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                ),
                              ),
                              const SizedBox(height: 32),
                              
                              // Name field
                              TextField(
                                decoration: InputDecoration(
                                  labelText: 'Full Name',
                                  prefixIcon: const Icon(Icons.person),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                      color: Colors.grey[300]!,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                      color: themeProvider.currentTheme.primaryColor,
                                    ),
                                  ),
                                ),
                                onChanged: signupProvider.setName,
                              ),
                              const SizedBox(height: 16),
                              
                              // Email field
                              TextField(
                                decoration: InputDecoration(
                                  labelText: 'Email Address',
                                  prefixIcon: const Icon(Icons.email),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                      color: Colors.grey[300]!,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                      color: themeProvider.currentTheme.primaryColor,
                                    ),
                                  ),
                                  errorText: signupProvider.email.isNotEmpty && !signupProvider.isEmailValid() 
                                      ? 'Please enter a valid email' 
                                      : null,
                                ),
                                keyboardType: TextInputType.emailAddress,
                                onChanged: signupProvider.setEmail,
                              ),
                              const SizedBox(height: 16),
                              
                              // Password field
                              TextField(
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  prefixIcon: const Icon(Icons.lock),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      signupProvider.obscurePassword 
                                          ? Icons.visibility_off 
                                          : Icons.visibility,
                                    ),
                                    onPressed: signupProvider.togglePasswordVisibility,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                      color: Colors.grey[300]!,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                      color: themeProvider.currentTheme.primaryColor,
                                    ),
                                  ),
                                  errorText: signupProvider.password.isNotEmpty && signupProvider.password.length < 6 
                                      ? 'Password must be at least 6 characters' 
                                      : null,
                                ),
                                obscureText: signupProvider.obscurePassword,
                                onChanged: signupProvider.setPassword,
                              ),
                              const SizedBox(height: 24),
                              
                              // Signup button
                              SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: ElevatedButton(
                                  onPressed: signupProvider.isFormValid() && !signupProvider.isLoading
                                      ? () async {
                                          final success = await signupProvider.signup();
                                          if (success) {
                                            if (context.mounted) {
                                              // Navigate to next screen after successful signup
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>  SignupPage(),
                                                ),
                                              );
                                            }
                                          }
                                        }
                                      : null,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: themeProvider.currentTheme.primaryColor,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    elevation: 2,
                                  ),
                                  child: signupProvider.isLoading
                                      ? const SizedBox(
                                          width: 24,
                                          height: 24,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 2.0,
                                          ),
                                        )
                                      : const Text(
                                          'SIGN UP',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                ),
                              ),
                              const SizedBox(height: 24),
                              
                              // Already have an account link
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Already have an account?',
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>  LoginScreen(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      'Log In',
                                      style: TextStyle(
                                        color: themeProvider.currentTheme.primaryColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}