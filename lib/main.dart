import 'package:flutter/material.dart';

import 'screens/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const AlWazirApp());
}

class AlWazirApp extends StatelessWidget {
  const AlWazirApp({super.key});

  static const gold = Color(0xFFFFC107);
  static const header = Color(0xFF1F2C34);
  static const background = Color(0xFF0F1417);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'الفهد',

      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,

        scaffoldBackgroundColor: background,

        colorScheme: ColorScheme.fromSeed(
          seedColor: gold,
          brightness: Brightness.dark,
        ),

        appBarTheme: const AppBarTheme(
          backgroundColor: header,
          foregroundColor: Colors.white,
          elevation: 0,
        ),

        dividerColor: const Color(0xFF3B4146),
      ),

      home: const Directionality(
        textDirection: TextDirection.rtl,
        child: HomeScreen(),
      ),
    );
  }
}
