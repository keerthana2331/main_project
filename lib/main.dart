import 'package:flutter/material.dart';
import 'package:navigation_screens/provider/screen1_provider.dart';
import 'package:provider/provider.dart';
import 'package:navigation_screens/screens/screen1.dart';

// Define the ThemeProvider class for theme management
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
}

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Screen1Provider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
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
            colorScheme: ColorScheme.fromSwatch().copyWith(
              primary: themeProvider.currentTheme.primaryColor,
              secondary: themeProvider.currentTheme.accentColor,
            ),
          ),
          debugShowCheckedModeBanner: false,
          home: Screen1(),
        );
      },
    );
  }
}