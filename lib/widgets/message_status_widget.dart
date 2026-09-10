import 'package:flutter/material.dart';

enum MessageStatus { sent, delivered, read }

class MessageStatusWidget extends StatelessWidget {
  final MessageStatus status;
  final String timeText;

  const MessageStatusWidget({
    Key? key,
    required this.status,
    required this.timeText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget statusIcon;

    switch (status) {
      case MessageStatus.sent:
        statusIcon = const Icon(Icons.check, size: 16, color: Colors.grey);
        break;
      case MessageStatus.delivered:
        statusIcon = const Icon(Icons.done_all, size: 16, color: Colors.grey);
        break;
      case MessageStatus.read:
        statusIcon = const Icon(Icons.done_all, size: 16, color: Colors.blue);
        break;
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          timeText,
          style: const TextStyle(fontSize: 10, color: Colors.grey),
        ),
        const SizedBox(width: 4),
        statusIcon,
      ],
    );
  }
}
