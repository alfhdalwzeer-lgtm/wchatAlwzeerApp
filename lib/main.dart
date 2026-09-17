import 'package:flutter/material.dart';

void main() {
  runApp(const AlWazirChatApp());
}

class AlWazirChatApp extends StatelessWidget {
  const AlWazirChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Al-Wazir Royal Chat App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0F172A),
        primaryColor: const Color(0xFFEAB308),
      ),
      home: const PhoneLoginScreen(),
    );
  }
}

// ---------------------------------------------------------
// 1. شاشة تسجيل الدخول برقم الهاتف
// ---------------------------------------------------------
class PhoneLoginScreen extends StatefulWidget {
  const PhoneLoginScreen({super.key});

  @override
  State<PhoneLoginScreen> createState() => _PhoneLoginScreenState();
}

class _PhoneLoginScreenState extends State<PhoneLoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  String _selectedCountryCode = '+967';

  @override
  Widget build(BuildContext context) {
    const goldColor = Color(0xFFEAB308);
    const cardColor = Color(0xFF1E293B);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 36.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),
              Center(
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: goldColor.withOpacity(0.15),
                    shape: BoxShape.circle,
                    border: Border.all(color: goldColor, width: 2),
                  ),
                  child: const Icon(Icons.phone_android, color: goldColor, size: 40),
                ),
              ),
              const SizedBox(height: 24),
              const Center(
                child: Text(
                  'تطبيق الفهد',
                  style: TextStyle(color: goldColor, fontSize: 26, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 8),
              const Center(
                child: Text('أدخل رقم هاتفك للمتابعة وتسجيل الدخول', style: TextStyle(color: Colors.white70, fontSize: 14)),
              ),
              const SizedBox(height: 48),
              Container(
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white12),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: Row(
                  children: [
                    DropdownButton<String>(
                      value: _selectedCountryCode,
                      dropdownColor: cardColor,
                      underline: const SizedBox(),
                      icon: const Icon(Icons.arrow_drop_down, color: goldColor),
                      style: const TextStyle(color: goldColor, fontSize: 16, fontWeight: FontWeight.bold),
                      onChanged: (String? newValue) {
                        if (newValue != null) setState(() => _selectedCountryCode = newValue);
                      },
                      items: <String>['+967', '+966', '+971', '+965', '+20']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(value: value, child: Text(value, textDirection: TextDirection.ltr));
                      }).toList(),
                    ),
                    const VerticalDivider(color: Colors.white24, thickness: 1, indent: 8, endIndent: 8),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        style: const TextStyle(color: Colors.white, fontSize: 16),
                        decoration: const InputDecoration(
                          hintText: '770 000 000',
                          hintStyle: TextStyle(color: Colors.white30),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  final fullPhoneNumber = '$_selectedCountryCode ${_phoneController.text}';
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OtpVerificationScreen(phoneNumber: fullPhoneNumber)),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: goldColor,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: const Text('إرسال رمز التحقق', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------
// 2. شاشة رمز التحقق OTP
// ---------------------------------------------------------
class OtpVerificationScreen extends StatefulWidget {
  final String phoneNumber;
  const OtpVerificationScreen({super.key, required this.phoneNumber});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final List<TextEditingController> _controllers = List.generate(4, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());

  @override
  void dispose() {
    for (var c in _controllers) {
      c.dispose();
    }
    for (var n in _focusNodes) {
      n.dispose();
    }
    super.dispose();
  }

  void _onOtpDigitChanged(int index, String value) {
    if (value.isNotEmpty && index < 3) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    const goldColor = Color(0xFFEAB308);
    const cardColor = Color(0xFF1E293B);

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text('رمز التحقق OTP', textAlign: TextAlign.center, style: TextStyle(color: goldColor, fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              Text('تم إرسال رمز التحقق إلى الرقم:\n${widget.phoneNumber}', textAlign: TextAlign.center, style: const TextStyle(color: Colors.white70, fontSize: 14)),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainSpacing.spaceEvenly,
                children: List.generate(4, (index) {
                  return Container(
                    width: 60,
                    height: 65,
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: goldColor, width: 1.5),
                    ),
                    child: TextField(
                      controller: _controllers[index],
                      focusNode: _focusNodes[index],
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      maxLength: 1,
                      style: const TextStyle(color: goldColor, fontSize: 24, fontWeight: FontWeight.bold),
                      decoration: const InputDecoration(counterText: '', border: InputBorder.none),
                      onChanged: (v) => _onOtpDigitChanged(index, v),
                    ),
                  );
                }),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MainHomeScreen()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: goldColor,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: const Text('تأكيد والدخول', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------
// 3. الشاشة الرئيسية للتطبيق (الدردشات والحالة)
// ---------------------------------------------------------
class MainHomeScreen extends StatelessWidget {
  const MainHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const goldColor = Color(0xFFEAB308);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('الفهد', style: TextStyle(color: goldColor, fontWeight: FontWeight.bold, fontSize: 22)),
          backgroundColor: const Color(0xFF0F172A),
          actions: [
            IconButton(icon: const Icon(Icons.search, color: Colors.white), onPressed: () {}),
            PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert, color: Colors.white),
              color: const Color(0xFF1E293B),
              onSelected: (value) {
                if (value == 'settings') {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsScreen()));
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(value: 'profile', child: Text('الملف الشخصي', style: TextStyle(color: Colors.white))),
                const PopupMenuItem(value: 'contacts', child: Text('جهات الاتصال', style: TextStyle(color: Colors.white))),
                const PopupMenuItem(value: 'calls', child: Text('المكالمات', style: TextStyle(color: Colors.white))),
                const PopupMenuItem(value: 'settings', child: Text('الإعدادات', style: TextStyle(color: Colors.white))),
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
            Center(child: Text('قائمة المحادثات', style: TextStyle(color: Colors.white54))),
            Center(child: Text('قائمة الحالات', style: TextStyle(color: Colors.white54))),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------
// 4. شاشة الإعدادات
// ---------------------------------------------------------
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isDarkMode = true;

  @override
  Widget build(BuildContext context) {
    const goldColor = Color(0xFFEAB308);

    return Scaffold(
      appBar: AppBar(
        title: const Text('الإعدادات', style: TextStyle(color: goldColor, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF0F172A),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const ListTile(
            leading: Icon(Icons.person, color: goldColor),
            title: Text('الحساب', style: TextStyle(color: Colors.white)),
            subtitle: Text('الملف الشخصي والخصوصية', style: TextStyle(color: Colors.white54)),
          ),
          SwitchListTile(
            activeColor: goldColor,
            title: const Text('الوضع الداكن', style: TextStyle(color: Colors.white)),
            value: isDarkMode,
            onChanged: (v) => setState(() => isDarkMode = v),
          ),
        ],
      ),
    );
  }
}
