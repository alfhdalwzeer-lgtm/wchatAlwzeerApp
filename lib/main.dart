import 'package:flutter/material.dart';

void main() {
  runApp(const AlWazirChatApp());
}

// =========================================================
// الألوان والثوابت
// =========================================================

const Color goldColor = Color(0xFFEAB308);
const Color backgroundColor = Color(0xFF0F172A);
const Color cardColor = Color(0xFF1E293B);

// =========================================================
// التطبيق الرئيسي
// =========================================================

class AlWazirChatApp extends StatelessWidget {
  const AlWazirChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Al-Wazir Royal Chat App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: backgroundColor,
        colorScheme: ColorScheme.fromSeed(
          seedColor: goldColor,
          brightness: Brightness.dark,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: backgroundColor,
          elevation: 0,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: InputBorder.none,
        ),
      ),
      home: const PhoneLoginScreen(),
    );
  }
}

// =========================================================
// 1. شاشة تسجيل الدخول برقم الهاتف
// =========================================================

class PhoneLoginScreen extends StatefulWidget {
  const PhoneLoginScreen({super.key});

  @override
  State<PhoneLoginScreen> createState() => _PhoneLoginScreenState();
}

class _PhoneLoginScreenState extends State<PhoneLoginScreen> {
  final TextEditingController _phoneController = TextEditingController();

  String _selectedCountryCode = '+967';

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _sendOtp() {
    final phone = _phoneController.text.trim();

    if (phone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('يرجى إدخال رقم الهاتف'),
        ),
      );
      return;
    }

    final fullPhoneNumber = '$_selectedCountryCode $phone';

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OtpVerificationScreen(
          phoneNumber: fullPhoneNumber,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 36,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 40),

                // الشعار
                Center(
                  child: Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      color: goldColor.withOpacity(0.15),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: goldColor,
                        width: 2,
                      ),
                    ),
                    child: const Icon(
                      Icons.phone_android,
                      color: goldColor,
                      size: 42,
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                const Text(
                  'تطبيق الفهد',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: goldColor,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  'أدخل رقم هاتفك للمتابعة وتسجيل الدخول',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),

                const SizedBox(height: 48),

                // حقل الهاتف
                Container(
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.white12,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 4,
                  ),
                  child: Row(
                    children: [
                      DropdownButton<String>(
                        value: _selectedCountryCode,
                        dropdownColor: cardColor,
                        underline: const SizedBox(),
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          color: goldColor,
                        ),
                        style: const TextStyle(
                          color: goldColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              _selectedCountryCode = value;
                            });
                          }
                        },
                        items: const [
                          '+967',
                          '+966',
                          '+971',
                          '+965',
                          '+20',
                        ].map((code) {
                          return DropdownMenuItem<String>(
                            value: code,
                            child: Text(
                              code,
                              textDirection: TextDirection.ltr,
                            ),
                          );
                        }).toList(),
                      ),

                      const SizedBox(width: 8),

                      Container(
                        width: 1,
                        height: 35,
                        color: Colors.white24,
                      ),

                      const SizedBox(width: 8),

                      Expanded(
                        child: TextField(
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          textDirection: TextDirection.ltr,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                          decoration: const InputDecoration(
                            hintText: '770 000 000',
                            hintStyle: TextStyle(
                              color: Colors.white30,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const Spacer(),

                // زر إرسال OTP
                SizedBox(
                  height: 55,
                  child: ElevatedButton(
                    onPressed: _sendOtp,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: goldColor,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      'إرسال رمز التحقق',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

  // =========================================================
// 2. شاشة رمز التحقق OTP
// =========================================================

class OtpVerificationScreen extends StatefulWidget {
  final String phoneNumber;

  const OtpVerificationScreen({
    super.key,
    required this.phoneNumber,
  });

  @override
  State<OtpVerificationScreen> createState() =>
      _OtpVerificationScreenState();
}

class _OtpVerificationScreenState
    extends State<OtpVerificationScreen> {
  final List<TextEditingController> _controllers =
      List.generate(4, (_) => TextEditingController());

  final List<FocusNode> _focusNodes =
      List.generate(4, (_) => FocusNode());

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }

    for (final node in _focusNodes) {
      node.dispose();
    }

    super.dispose();
  }

  void _onOtpDigitChanged(
    int index,
    String value,
  ) {
    if (value.isNotEmpty && index < 3) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  void _verifyOtp() {
    final otp = _controllers.map((e) => e.text).join();

    if (otp.length != 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('يرجى إدخال رمز التحقق كاملًا'),
        ),
      );
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const MainHomeScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'رمز التحقق OTP',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: goldColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 12),

                Text(
                  'تم إرسال رمز التحقق إلى الرقم:\n${widget.phoneNumber}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),

                const SizedBox(height: 40),

                // مربعات OTP
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceEvenly,
                  children: List.generate(
                    4,
                    (index) {
                      return Container(
                        width: 60,
                        height: 65,
                        decoration: BoxDecoration(
                          color: cardColor,
                          borderRadius:
                              BorderRadius.circular(14),
                          border: Border.all(
                            color: goldColor,
                            width: 1.5,
                          ),
                        ),
                        child: TextField(
                          controller: _controllers[index],
                          focusNode: _focusNodes[index],
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          maxLength: 1,
                          style: const TextStyle(
                            color: goldColor,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                          decoration:
                              const InputDecoration(
                            counterText: '',
                          ),
                          onChanged: (value) {
                            _onOtpDigitChanged(
                              index,
                              value,
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),

                const Spacer(),

                SizedBox(
                  height: 55,
                  child: ElevatedButton(
                    onPressed: _verifyOtp,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: goldColor,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      'تأكيد والدخول',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// =========================================================
// 3. الشاشة الرئيسية
// =========================================================

class MainHomeScreen extends StatelessWidget {
  const MainHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'الفهد 👑',
              style: TextStyle(
                color: goldColor,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                onPressed: () {},
              ),

              PopupMenuButton<String>(
                icon: const Icon(
                  Icons.more_vert,
                  color: Colors.white,
                ),
                color: cardColor,
                onSelected: (value) {
                  if (value == 'settings') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const SettingsScreen(),
                      ),
                    );
                  }
                },
                itemBuilder: (context) => const [
                  PopupMenuItem(
                    value: 'profile',
                    child: Text(
                      'الملف الشخصي',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  PopupMenuItem(
                    value: 'contacts',
                    child: Text(
                      'جهات الاتصال',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  PopupMenuItem(
                    value: 'calls',
                    child: Text(
                      'المكالمات',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  PopupMenuItem(
                    value: 'settings',
                    child: Text(
                      'الإعدادات',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],

            bottom: const TabBar(
              indicatorColor: goldColor,
              labelColor: goldColor,
              unselectedLabelColor: Colors.white54,
              tabs: [
                Tab(text: 'الدردشات'),
                Tab(text: 'الحالة'),
              ],
            ),
          ),

          body: const TabBarView(
            children: [
              Center(
                child: Text(
                  'قائمة المحادثات',
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 16,
                  ),
                ),
              ),
              Center(
                child: Text(
                  'قائمة الحالات',
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =========================================================
// 4. شاشة الإعدادات
// =========================================================

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() =>
      _SettingsScreenState();
}

class _SettingsScreenState
    extends State<SettingsScreen> {
  bool isDarkMode = true;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'الإعدادات',
            style: TextStyle(
              color: goldColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const ListTile(
              leading: Icon(
                Icons.person,
                color: goldColor,
              ),
              title: Text(
                'الحساب',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              subtitle: Text(
                'الملف الشخصي والخصوصية',
                style: TextStyle(
                  color: Colors.white54,
                ),
              ),
            ),

            const Divider(
              color: Colors.white12,
            ),

            SwitchListTile(
              activeColor: goldColor,
              title: const Text(
                'الوضع الداكن',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              value: isDarkMode,
              onChanged: (value) {
                setState(() {
                  isDarkMode = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
