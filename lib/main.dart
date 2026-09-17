import 'phone_login_screen.dart';
  rt 'package:flutter/material.dart';

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
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _onOtpDigitChanged(int index, String value) {
    if (value.isNotEmpty) {
      if (index < 3) {
        _focusNodes[index + 1].requestFocus();
      } else {
        _focusNodes[index].unfocus(); // إغلاق لوحة المفاتيح عند إكمال الرمز
      }
    } else if (index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    const goldColor = Color(0xFFEAB308);
    const bgColor = Color(0xFF0F172A);
    const cardColor = Color(0xFF1E293B);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              
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
                'تم إرسال رمز التحقق المكون من 4 أرقام إلى الرقم:\n${widget.phoneNumber}',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white70, fontSize: 14, height: 1.5),
                textDirection: TextDirection.rtl,
              ),

              const SizedBox(height: 40),

              // مربعات إدخال الرمز الـ 4
              Row(
                mainAxisAlignment: MainSpacing.spaceEvenly,
                children: List.generate(4, (index) {
                  return Container(
                    width: 60,
                    height: 65,
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: _controllers[index].text.isNotEmpty ? goldColor : Colors.white24,
                        width: 1.5,
                      ),
                    ),
                    child: TextField(
                      controller: _controllers[index],
                      focusNode: _focusNodes[index],
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      maxLength: 1,
                      style: const TextStyle(color: goldColor, fontSize: 24, fontWeight: FontWeight.bold),
                      decoration: const InputDecoration(
                        counterText: '',
                        border: InputBorder.none,
                      ),
                      onChanged: (value) => _onOtpDigitChanged(index, value),
                    ),
                  );
                }),
              ),

              const SizedBox(height: 32),

              // خيار إعادة الإرسال
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('لم تصلك الرسالة؟ ', style: TextStyle(color: Colors.white54)),
                  GestureDetector(
                    onTap: () {
                      // كود إعادة إرسال الرمز
                    },
                    child: const Text(
                      'إعادة إرسال',
                      style: TextStyle(color: goldColor, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),

              const Spacer(),

              // زر التأكيد
              ElevatedButton(
                onPressed: () {
                  String otp = _controllers.map((c) => c.text).join();
                  // تنفيذ التحقق والذهاب إلى الواجهة الرئيسية
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: goldColor,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 4,
                ),
                child: const Text(
                  'تأكيد والدخول',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
