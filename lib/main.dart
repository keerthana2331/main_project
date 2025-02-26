import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:navigation_screens/provider/forget_password_provider.dart';
import 'package:navigation_screens/provider/screen2_provider.dart';
import 'package:navigation_screens/provider/screen1_provider.dart';
import 'package:navigation_screens/screens/screen2.dart';

import 'package:provider/provider.dart';

// Define the ThemeProvider class for theme management
class ThemeProvider with ChangeNotifier {
  ThemeOption _currentTheme = ThemeOption(
    name: "Ocean Blue",
    primaryColor: const Color(0xFF1A2980),
    accentColor: const Color(0xFF26D0CE),
  );

  ThemeOption get currentTheme => _currentTheme;

  void setTheme(ThemeOption theme) {
    _currentTheme = theme;
    notifyListeners();
  }
}

// ThemeOption class to hold theme data
class ThemeOption {
  final String name;
  final Color primaryColor;
  final Color accentColor;

  ThemeOption({
    required this.name,
    required this.primaryColor,
    required this.accentColor,
  });

  // ✅ Properly define colorScheme getter
  ColorScheme get colorScheme => ColorScheme.fromSwatch().copyWith(
        primary: primaryColor,
        secondary: accentColor,
      );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // ✅ Initialize Firebase properly

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Screen1Provider()),
        ChangeNotifierProvider(create: (_) => ForgetPasswordProvider()), 
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => ChatListProvider()), // ✅ Included in MultiProvider
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'SmartChatHub',
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            primaryColor: themeProvider.currentTheme.primaryColor,
            colorScheme: themeProvider.currentTheme.colorScheme, // ✅ Used the fixed colorScheme getter
          ),
          debugShowCheckedModeBanner: false,
          home: const Screen2(), // ✅ Ensured it is a constant if possible
        );
      },
    );
  }
}
