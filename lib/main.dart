import 'package:flutter/material.dart';
import 'package:navigation_screens/provider/screen1_provider.dart';
import 'package:provider/provider.dart';

import 'package:navigation_screens/screens/screen1.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Screen1Provider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      home: Screen1(),
    );
  }
}
