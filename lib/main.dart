import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const AlWazirChatApp());
}

class AlWazirChatApp extends StatelessWidget {
  const AlWazirChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'الفهد شات',
      debugShowCheckedModeBanner: false,
      
      // دعم اللغة العربية والاتجاه من اليمين لليار (RTL)
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ar', 'YE'), // اللغة العربية
      ],
      locale: const Locale('ar', 'YE'),

      // الثيم الداكن الذهبي المطابق للواجهات
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0F172A),
        primaryColor: const Color(0xFFEAB308),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0F172A),
          elevation: 0,
          centerTitle: false,
          titleTextStyle: TextStyle(
            color: Color(0xFFEAB308),
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFEAB308),
          surface: Color(0xFF1E293B),
        ),
      ),

      // الشاشة الابتدائية (شاشة تسجيل الدخول أو الرئيسية)
      home: const MainNavigationScreen(),
    );
  }
}

// شاشة التنقل الرئيسية (Bottom Navigation Bar)
class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    Center(child: Text('صفحة الدردشات', style: TextStyle(color: Colors.white))),
    Center(child: Text('صفحة المجموعات', style: TextStyle(color: Colors.white))),
    Center(child: Text('صفحة المكالمات', style: TextStyle(color: Colors.white))),
    Center(child: Text('صفحة الحالة', style: TextStyle(color: Colors.white))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF0F172A),
        selectedItemColor: const Color(0xFFEAB308),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            activeIcon: Icon(Icons.chat_bubble),
            label: 'الدردشات',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group_outlined),
            activeIcon: Icon(Icons.group),
            label: 'المجموعات',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.phone_outlined),
            activeIcon: Icon(Icons.phone),
            label: 'المكالمات',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.circle_notifications_outlined),
            activeIcon: Icon(Icons.circle_notifications),
            label: 'الحالة',
          ),
        ],
      ),
    );
  }
}
