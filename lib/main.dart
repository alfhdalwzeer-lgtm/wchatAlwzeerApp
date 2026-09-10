import 'package:flutter/material.dart';
import 'widgets/message_status_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Al-Wazir Chat',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0F1417),
        appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF1F2C34)),
      ),
      home: const ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  bool _isWriting = false;
  bool _isRecording = false;

  final List<Map<String, dynamic>> _messages = [
    {
      'text': 'السلام عليكم، مرحباً بك في Al-Wazir Chat 👑',
      'isMe': false,
      'isAudio': false,
      'time': '10:00 ص',
      'status': MessageStatus.read,
    },
    {
      'text': 'وعليكم السلام! تطبيق ممتاز جداً.',
      'isMe': true,
      'isAudio': false,
      'time': '10:01 ص',
      'status': MessageStatus.read,
    },
  ];

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _isWriting = _controller.text.trim().isNotEmpty;
      });
    });
  }

  void _sendMessage() {
    if (_controller.text.trim().isEmpty) return;
    setState(() {
      _messages.add({
        'text': _controller.text,
        'isMe': true,
        'isAudio': false,
        'time': '10:02 ص',
        'status': MessageStatus.sent,
      });
      _controller.clear();
      _isWriting = false;
    });
  }

  void _toggleRecording() {
    setState(() {
      _isRecording = !_isRecording;
      if (!_isRecording) {
        // إضافة رسالة صوتية وهمية للعرض
        _messages.add({
          'text': 'رسالة صوتية (0:05)',
          'isMe': true,
          'isAudio': true,
          'time': '10:03 ص',
          'status': MessageStatus.sent,
        });
      }
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_isRecording ? 'جاري التسجيل الصوتي...' : 'تم إرسال التسجيل الصوتي'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          children: [
            const CircleAvatar(
              backgroundColor: Colors.amber,
              child: Icon(Icons.person, color: Colors.black),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('مستخدم Al-Wazir', style: TextStyle(fontSize: 16)),
                Text('متصل الآن', style: TextStyle(fontSize: 12, color: Colors.greenAccent)),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                final isMe = msg['isMe'] as bool;
                final isAudio = msg['isAudio'] as bool? ?? false;

                return Align(
                  alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: isMe ? const Color(0xFF005C4B) : const Color(0xFF202C33),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        if (isAudio)
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.play_arrow, color: Colors.amber, size: 28),
                              const SizedBox(width: 6),
                              Text(msg['text'], style: const TextStyle(color: Colors.white, fontSize: 14)),
                            ],
                          )
                        else
                          Text(msg['text'], style: const TextStyle(color: Colors.white, fontSize: 15)),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(msg['time'], style: const TextStyle(fontSize: 10, color: Colors.grey)),
                            if (isMe) ...[
                              const SizedBox(width: 4),
                              MessageStatusWidget(
                                status: msg['status'] as MessageStatus,
                                timeText: '',
                              ),
                            ]
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            color: const Color(0xFF1F2C34),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: _isRecording ? 'جاري التسجيل...' : 'اكتب رسالة...',
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                    ),
                    enabled: !_isRecording,
                  ),
                ),
                GestureDetector(
                  onTap: _isWriting ? _sendMessage : _toggleRecording,
                  child: CircleAvatar(
                    backgroundColor: _isRecording ? Colors.red : Colors.amber,
                    child: Icon(
                      _isWriting
                          ? Icons.send
                          : (_isRecording ? Icons.stop : Icons.mic),
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
