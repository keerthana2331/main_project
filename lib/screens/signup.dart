import 'package:flutter/material.dart';
import 'package:navigation_screens/main.dart';
import 'package:navigation_screens/provider/signup_provider.dart';
import 'package:navigation_screens/screens/loginscreen.dart';
import 'package:provider/provider.dart';
import 'dart:ui';

class SignupPage extends StatelessWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final size = MediaQuery.of(context).size;
    
    return ChangeNotifierProvider(
      create: (context) => SignupProvider(),
      child: Consumer<SignupProvider>(
        builder: (context, signupProvider, _) {
          return Scaffold(
            body: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    themeProvider.currentTheme.primaryColor,
                    themeProvider.currentTheme.accentColor,
                  ],
                ),
              ),
              child: SafeArea(
                child: Center(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Header with back button
                          Padding(
                            padding: const EdgeInsets.only(bottom: 24.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Create Account',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          
                          // Main card
                          Container(
                            width: double.infinity,
                            constraints: const BoxConstraints(
                              maxWidth: 450, // Maximum width for larger screens
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(24),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 10,
                                  spreadRadius: 0,
                                ),
                              ],
                              border: Border.all(
                                color: Colors.white.withOpacity(0.2),
                                width: 1.5,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(24),
                              child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                child: Padding(
                                  padding: const EdgeInsets.all(24.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      // Avatar
                                      Container(
                                        padding: const EdgeInsets.all(16),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white.withOpacity(0.3),
                                          boxShadow: [
                                            BoxShadow(
                                              color: themeProvider.currentTheme.primaryColor.withOpacity(0.3),
                                              blurRadius: 20,
                                              spreadRadius: 2,
                                            ),
                                          ],
                                        ),
                                        child: const Icon(
                                          Icons.person_add_rounded,
                                          size: 40,
                                          color: Colors.white,
                                        ),
                                      ),
                                      
                                      const SizedBox(height: 24),
                                      
                                      // Header text
                                      const Text(
                                        'Welcome',
                                        style: TextStyle(
                                          fontSize: 28,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          letterSpacing: 1.2,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        'Create your account to get started',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white.withOpacity(0.8),
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(height: 32),
                                      
                                      // Form fields
                                      buildTextField(
                                        hint: 'Full Name',
                                        icon: Icons.person_outline_rounded,
                                        isPassword: false,
                                        isEmail: false,
                                        onChange: signupProvider.setName,
                                        errorText: null,
                                      ),
                                      const SizedBox(height: 16),
                                      buildTextField(
                                        hint: 'Email Address',
                                        icon: Icons.email_outlined,
                                        isPassword: false,
                                        isEmail: true,
                                        onChange: signupProvider.setEmail,
                                        errorText: signupProvider.email.isNotEmpty && !signupProvider.isEmailValid()
                                          ? 'Please enter a valid email'
                                          : null,
                                      ),
                                      const SizedBox(height: 16),
                                      buildTextField(
                                        hint: 'Password',
                                        icon: Icons.lock_outline_rounded,
                                        isPassword: true,
                                        isEmail: false,
                                        onChange: signupProvider.setPassword,
                                        errorText: signupProvider.password.isNotEmpty && signupProvider.password.length < 6
                                          ? 'Password must be at least 6 characters'
                                          : null,
                                        toggleVisibility: signupProvider.togglePasswordVisibility,
                                        isObscured: signupProvider.obscurePassword,
                                      ),
                                      const SizedBox(height: 32),
                                      
                                      // Sign up button
                                      SizedBox(
                                        width: double.infinity,
                                        height: 55,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            // Add signup logic here
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: themeProvider.currentTheme.primaryColor,
                                            foregroundColor: Colors.white,
                                            elevation: 4,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(16),
                                            ),
                                          ),
                                          child: const Text(
                                            'SIGN UP',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 1.5,
                                            ),
                                          ),
                                        ),
                                      ),
                                      
                                      const SizedBox(height: 24),
                                      
                                      // Or divider
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Divider(
                                              color: Colors.white.withOpacity(0.5),
                                              thickness: 0.5,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                            child: Text(
                                              'OR',
                                              style: TextStyle(
                                                color: Colors.white.withOpacity(0.8),
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Divider(
                                              color: Colors.white.withOpacity(0.5),
                                              thickness: 0.5,
                                            ),
                                          ),
                                        ],
                                      ),
                                      
                                      const SizedBox(height: 24),
                                      
                                      // Google sign in button
                                      SizedBox(
                                        width: double.infinity,
                                        height: 55,
                                        child: ElevatedButton.icon(
                                          onPressed: () async {
                                            final user = await signupProvider.signUpWithGoogle();
                                            if (user != null && context.mounted) {
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(builder: (context) => SignupPage()), // Replace with home screen
                                              );
                                            }
                                          },
                                          icon: Container(
                                            height: 24,
                                            width: 24,
                                            decoration: const BoxDecoration(
                                              image: DecorationImage(
                                                image: NetworkImage('https://upload.wikimedia.org/wikipedia/commons/5/53/Google_%22G%22_Logo.svg'),
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          ),
                                          label: const Text(
                                            'Sign in with Google',
                                            style: TextStyle(
                                              color: Colors.black87,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.white,
                                            foregroundColor: Colors.black87,
                                            elevation: 2,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(16),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          
                          const SizedBox(height: 24),
                          
                          // Login link
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Already have an account?',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.8),
                                  fontSize: 15,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) => LoginScreen()),
                                  );
                                },
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.white,
                                ),
                                child: const Text(
                                  'Log In',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    decoration: TextDecoration.underline,
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
          );
        },
      ),
    );
  }

  // Custom text field builder
  Widget buildTextField({
    required String hint,
    required IconData icon,
    required bool isPassword,
    required bool isEmail,
    required Function(String) onChange,
    String? errorText,
    bool isObscured = false,
    VoidCallback? toggleVisibility,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: TextField(
        obscureText: isPassword ? isObscured : false,
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
        onChanged: onChange,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
          hintText: hint,
          hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
          prefixIcon: Icon(
            icon,
            color: Colors.white.withOpacity(0.7),
            size: 22,
          ),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    isObscured ? Icons.visibility_off : Icons.visibility,
                    color: Colors.white.withOpacity(0.7),
                  ),
                  onPressed: toggleVisibility,
                )
              : null,
          errorText: errorText,
          errorStyle: const TextStyle(
            color: Colors.redAccent,
            fontWeight: FontWeight.w500,
          ),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }
}